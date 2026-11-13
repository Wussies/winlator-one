#!/usr/bin/env python3
"""NEXORA Stage 0 audit: static pattern checks, manifest permissions, workflow review,
binary inventory and declared-dependency extraction.

This script never executes code from the scanned project. It only reads files.
Usage: static_checks.py <target_dir> <out_dir> [extract_dir]
"""
import hashlib, json, os, re, subprocess, sys, tarfile, zipfile, collections, pathlib

TARGET = pathlib.Path(sys.argv[1]).resolve()
OUT = pathlib.Path(sys.argv[2]).resolve()
EXTRACT = pathlib.Path(sys.argv[3]).resolve() if len(sys.argv) > 3 else None
OUT.mkdir(parents=True, exist_ok=True)

SRC_EXT = {".kt", ".kts", ".java", ".c", ".cc", ".cpp", ".h", ".hpp", ".rs", ".sh", ".py", ".gradle", ".yml", ".yaml", ".ps1", ".js"}
SKIP_DIRS = {".git", "build", ".gradle", "node_modules"}

PATTERNS = {
    "exec: Runtime.exec / ProcessBuilder": r"Runtime\.getRuntime\(\)\.exec|ProcessBuilder\s*\(",
    "exec: native system/popen/exec*": r"\b(system|popen|execve|execvp|execl|execv)\s*\(",
    "dynamic code: DexClassLoader / InMemoryDex": r"DexClassLoader|InMemoryDexClassLoader|PathClassLoader\s*\(",
    "dynamic native: System.load / dlopen": r"System\.load\s*\(|System\.loadLibrary\s*\(|\bdlopen\s*\(",
    "webview: addJavascriptInterface": r"addJavascriptInterface",
    "webview: file access enabled": r"setAllowFileAccess(FromFileURLs)?\s*\(\s*true|setAllowUniversalAccessFromFileURLs\s*\(\s*true|allowFileAccess\s*=\s*true",
    "tls: trust-all / hostname bypass": r"checkServerTrusted\s*\([^)]*\)\s*\{\s*\}|HostnameVerifier\s*\{[^}]*true|ALLOW_ALL_HOSTNAME_VERIFIER|hostnameVerifier\s*\{\s*_?,\s*_?\s*->\s*true",
    "cleartext http:// URL": r"\"http://(?!localhost|127\.|10\.0\.2\.2|schemas\.android|www\.w3\.org|xml\.org|apache\.org|ns\.adobe)[^\"]+\"",
    "secrets in logs (password/token logged)": r"(Log\.[dviwe]|Timber\.[dviwe]|println)\s*\([^)]*(password|refreshToken|accessToken|secret)",
    "base64 blob (>200 chars)": r"[A-Za-z0-9+/]{200,}={0,2}",
    "analytics/telemetry SDK": r"PostHog|posthog|Sentry\.|Firebase|Crashlytics|Amplitude|Mixpanel|AppsFlyer|Adjust\.",
    "LD_PRELOAD / library injection": r"LD_PRELOAD",
    "chmod / setExecutable": r"setExecutable\s*\(|chmod\s*\(|\"chmod",
    "package spoofing (other apps' ids)": r"com\.tencent\.ig|com\.antutu|com\.ludashi|com\.miHoYo|com\.netease",
    "Steam API emulator (gbe_fork/Goldberg/ColdClient)": r"gbe_fork|[Gg]oldberg|ColdClient|steam_settings",
}

def iter_files():
    for root, dirs, files in os.walk(TARGET):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        for f in files:
            yield pathlib.Path(root) / f

def rel(p):
    return str(p.relative_to(TARGET))

def sha256(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

def magic(p):
    try:
        with open(p, "rb") as fh:
            head = fh.read(8)
    except OSError:
        return None
    if head.startswith(b"\x7fELF"): return "ELF"
    if head.startswith(b"MZ"): return "PE"
    if head.startswith(b"PK\x03\x04"): return "ZIP"
    if head.startswith(b"\x28\xb5\x2f\xfd"): return "ZSTD"
    if head.startswith(b"\xfd7zXZ"): return "XZ"
    if head.startswith(b"\x1f\x8b"): return "GZIP"
    if head.startswith(b"dex\n"): return "DEX"
    return None

# ---------- 1. pattern checks ----------
hits = collections.defaultdict(list)
compiled = {k: re.compile(v) for k, v in PATTERNS.items()}
for p in iter_files():
    if p.suffix not in SRC_EXT or p.stat().st_size > 3_000_000:
        continue
    try:
        text = p.read_text(errors="ignore")
    except OSError:
        continue
    for n, line in enumerate(text.splitlines(), 1):
        if len(line) > 2000:
            line = line[:2000]
        for k, rx in compiled.items():
            if rx.search(line):
                hits[k].append(f"{rel(p)}:{n}: {line.strip()[:180]}")

# ---------- 2. manifest permissions ----------
perms = collections.Counter()
exported = []
for p in iter_files():
    if p.name == "AndroidManifest.xml":
        t = p.read_text(errors="ignore")
        for m in re.finditer(r"uses-permission[^>]*android:name=\"([^\"]+)\"", t):
            perms[m.group(1)] += 1
        for m in re.finditer(r"<(activity|service|receiver|provider)[^>]*android:exported=\"true\"[^>]*android:name=\"([^\"]+)\"|<(activity|service|receiver|provider)[^>]*android:name=\"([^\"]+)\"[^>]*android:exported=\"true\"", t):
            exported.append(f"{rel(p)}: {m.group(2) or m.group(4)}")

# ---------- 3. CI workflow review ----------
wf_findings = []
for p in TARGET.glob(".github/workflows/*.y*ml"):
    t = p.read_text(errors="ignore")
    if "pull_request_target" in t:
        wf_findings.append(f"{rel(p)}: uses pull_request_target (review for untrusted checkout)")
    for m in re.finditer(r"uses:\s*([^\s#]+)", t):
        ref = m.group(1)
        if "@" in ref and not re.search(r"@[0-9a-f]{40}$", ref) and not ref.startswith("./"):
            wf_findings.append(f"{rel(p)}: action not pinned to SHA: {ref}")
    if re.search(r"curl[^\n|]*\|\s*(ba)?sh", t):
        wf_findings.append(f"{rel(p)}: pipes curl into shell")
    if "secrets." in t:
        n_sec = len(re.findall(r"secrets\.", t))
        wf_findings.append(f"{rel(p)}: uses secrets ({n_sec} refs)")

# ---------- 4. binary inventory ----------
binaries = []
for p in iter_files():
    kind = magic(p)
    if kind is None:
        continue
    if kind in ("ZIP",) and p.suffix in (".kt", ".java"):
        continue
    size = p.stat().st_size
    if size < 1024 and kind not in ("ELF", "PE"):
        continue
    binaries.append({"path": rel(p), "type": kind, "size": size, "sha256": sha256(p)})

# Extract archives (read-only scan target for ClamAV, never executed)
inner = collections.Counter()
if EXTRACT:
    EXTRACT.mkdir(parents=True, exist_ok=True)
    for b in binaries:
        src = TARGET / b["path"]
        dst = EXTRACT / (b["path"].replace("/", "__"))
        try:
            if b["type"] in ("ZSTD", "XZ", "GZIP"):
                dst.mkdir(parents=True, exist_ok=True)
                flag = {"ZSTD": "--zstd", "XZ": "-J", "GZIP": "-z"}[b["type"]]
                r = subprocess.run(["tar", flag, "-xf", str(src), "-C", str(dst), "--no-same-owner", "--no-same-permissions"],
                                   capture_output=True, timeout=600)
                b["extracted"] = r.returncode == 0
            elif b["type"] == "ZIP" and src.suffix.lower() in (".zip", ".wcp", ".jar", ".aar", ".apk", ".adpkg"):
                dst.mkdir(parents=True, exist_ok=True)
                with zipfile.ZipFile(src) as z:
                    for name in z.namelist():
                        if ".." in name or name.startswith("/"):
                            continue
                        z.extract(name, dst)
                b["extracted"] = True
        except Exception as e:  # noqa
            b["extracted"] = f"failed: {e}"[:120]
    for root, _, files in os.walk(EXTRACT):
        for f in files:
            k = magic(pathlib.Path(root) / f)
            if k:
                inner[k] += 1

# ---------- 5. declared dependencies ----------
deps = set()
for toml in TARGET.rglob("libs.versions.toml"):
    t = toml.read_text(errors="ignore")
    versions = dict(re.findall(r"^\s*([\w.-]+)\s*=\s*\"([^\"]+)\"", t.split("[libraries]")[0], re.M))
    libs_part = t.split("[libraries]")[1].split("[plugins]")[0] if "[libraries]" in t else ""
    for line in libs_part.splitlines():
        mod = re.search(r"module\s*=\s*\"([^\"]+)\"", line)
        grp = re.search(r"group\s*=\s*\"([^\"]+)\"", line)
        nm = re.search(r"name\s*=\s*\"([^\"]+)\"", line)
        ver = re.search(r"version\s*=\s*\"([^\"]+)\"", line)
        vref = re.search(r"version\.ref\s*=\s*\"([^\"]+)\"", line)
        ga = mod.group(1) if mod else (f"{grp.group(1)}:{nm.group(1)}" if grp and nm else None)
        v = ver.group(1) if ver else (versions.get(vref.group(1)) if vref else None)
        if ga and v:
            deps.add(f"{ga}:{v}")
for g in list(TARGET.rglob("*.gradle")) + list(TARGET.rglob("*.gradle.kts")):
    if "build/" in str(g):
        continue
    for m in re.finditer(r"['\"]([\w.\-]+):([\w.\-]+):([\w.\-+]+)(@aar)?['\"]", g.read_text(errors="ignore")):
        if "$" not in m.group(3):
            deps.add(f"{m.group(1)}:{m.group(2)}:{m.group(3)}")

# ---------- write outputs ----------
(OUT / "patterns.json").write_text(json.dumps(hits, indent=1))
(OUT / "binaries.json").write_text(json.dumps(binaries, indent=1))
(OUT / "deps.txt").write_text("\n".join(sorted(deps)) + "\n")

md = [f"## Static checks: `{TARGET.name}`", ""]
md.append("### Pattern hits (count — first 8 locations)")
for k in PATTERNS:
    v = hits.get(k, [])
    md.append(f"- **{k}**: {len(v)}")
    for line in v[:8]:
        md.append(f"  - `{line.replace('`', ' ')}`")
md += ["", "### Android permissions requested", ""]
md += [f"- {p} (x{c})" for p, c in sorted(perms.items())] or ["- none"]
md += ["", f"### Exported components ({len(exported)})", ""] + [f"- {e}" for e in exported[:40]]
md += ["", "### CI workflow review", ""] + ([f"- {w}" for w in wf_findings] or ["- no workflows / no findings"])
tc = collections.Counter(b["type"] for b in binaries)
md += ["", "### Binary inventory", "", f"Top-level binary files: {dict(tc)}", f"Files found inside extracted archives: {dict(inner)}", "",
       "| path | type | MB | sha256 |", "|---|---|---|---|"]
for b in sorted(binaries, key=lambda x: -x["size"])[:60]:
    md.append(f"| {b['path']} | {b['type']} | {b['size']/1e6:.1f} | `{b['sha256'][:16]}…` |")
md += ["", f"### Declared dependencies: {len(deps)} (full list in deps.txt)"]
(OUT / "static.md").write_text("\n".join(md) + "\n")
print("\n".join(md[:5]))
