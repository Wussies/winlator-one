#!/usr/bin/env python3
"""NEXORA: fail the build when the APK's dex lacks a Java member that native code
looks up by name (GetMethodID / GetFieldID / jni-rs call_method ...).

R8 can strip or rename such members (this is what broke "Install system files"
in nexora-0.2.0-stage4-build.10..14). A member counts as ours when its name is
declared in the app's Java/Kotlin sources; framework members (File.getPath, ...)
are not in the APK's dex and are skipped.

usage: check-jni-dex.py <apk> <native-src-dir> <java-kotlin-src-dir>
"""
import os, re, sys, zipfile

LIT = re.compile(r'"((?:[^"\\]|\\.)*)"')
SIG_M = re.compile(r'^\((\[*([ZBCSIJFDV]|L[\w/$]+;))*\)(\[*([ZBCSIJFDV]|L[\w/$]+;))$')
IDENT = re.compile(r'^[A-Za-z_$][\w$]*$')
SKIP = ('/thirdparty', '/adrenotools', '/vkbasalt', '/proot', '/patchelf', '/target')


def native_refs(root):
    refs = set()
    for dp, _, fs in os.walk(root):
        if any(x in dp for x in SKIP):
            continue
        for f in fs:
            if not f.endswith(('.c', '.cpp', '.cc', '.h', '.hpp', '.rs')):
                continue
            p = os.path.join(dp, f)
            s = open(p, errors='ignore').read()
            lits = [(m.start(), m.group(1)) for m in LIT.finditer(s)]
            for (ppos, prev), (pos, v) in zip(lits, lits[1:]):
                if pos - ppos <= 200 and SIG_M.match(v) and IDENT.match(prev):
                    refs.add((prev, v, os.path.relpath(p, root)))
    return refs


def declared_names(src):
    names = set()
    decl = re.compile(r'(?:\bfun\s+(?:[\w.<>]+\.)?([A-Za-z_]\w*)\s*\()|(?:\b[\w<>\[\],.]+\s+([A-Za-z_]\w*)\s*\([^;{)]*\)\s*(?:throws [\w., ]+)?\{)')
    for dp, _, fs in os.walk(src):
        for f in fs:
            if f.endswith(('.java', '.kt')):
                for m in decl.finditer(open(os.path.join(dp, f), errors='ignore').read()):
                    names.add(m.group(1) or m.group(2))
    return names


def dex_methods(apk):
    from androguard.core.dex import DEX
    out = set()
    with zipfile.ZipFile(apk) as z:
        for n in z.namelist():
            if re.fullmatch(r'classes\d*\.dex', n):
                for c in DEX(z.read(n)).get_classes():
                    for m in c.get_methods():
                        out.add((m.get_name(), m.get_descriptor().replace(' ', '')))
    return out


def main():
    apk, native_src, app_src = sys.argv[1:4]
    import logging
    logging.disable(logging.CRITICAL)
    try:
        from loguru import logger
        logger.remove()
    except Exception:
        pass
    refs = native_refs(native_src)
    ours = declared_names(app_src)
    have = dex_methods(apk)
    missing = sorted(r for r in refs if r[0] in ours and (r[0], r[1]) not in have)
    print(f"JNI method references: {len(refs)}, declared in app sources: "
          f"{sum(1 for r in refs if r[0] in ours)}, missing from dex: {len(missing)}")
    for name, sig, src in missing:
        print(f"MISSING {name}{sig}  (used by {src})")
    sys.exit(1 if missing else 0)


if __name__ == '__main__':
    main()
