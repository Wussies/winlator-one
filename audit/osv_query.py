#!/usr/bin/env python3
"""Query OSV.dev for known vulnerabilities of declared Maven dependencies.

Only DIRECTLY declared coordinates are checked (we do not run the target's Gradle
build to resolve transitive dependencies, because that would execute unreviewed
build scripts). Usage: osv_query.py <deps.txt> <out.md>
"""
import json, sys, urllib.request

deps = [l.strip() for l in open(sys.argv[1]) if l.count(":") == 2]
queries = [{"package": {"ecosystem": "Maven", "name": f"{d.split(':')[0]}:{d.split(':')[1]}"}, "version": d.split(":")[2]} for d in deps]
results = []
for i in range(0, len(queries), 500):
    req = urllib.request.Request("https://api.osv.dev/v1/querybatch",
                                 data=json.dumps({"queries": queries[i:i + 500]}).encode(),
                                 headers={"Content-Type": "application/json"})
    results += json.load(urllib.request.urlopen(req, timeout=60))["results"]

lines = [f"## OSV.dev — declared Maven dependencies ({len(deps)} checked, direct only)", "",
         "| dependency | advisories |", "|---|---|"]
vulnerable = 0
for d, r in zip(deps, results):
    ids = [v["id"] for v in r.get("vulns", [])]
    if ids:
        vulnerable += 1
        lines.append(f"| {d} | {', '.join(ids[:12])}{' …' if len(ids) > 12 else ''} |")
lines.append("")
lines.append(f"**{vulnerable} of {len(deps)} declared dependencies have known advisories.**")
open(sys.argv[2], "w").write("\n".join(lines) + "\n")
print(lines[-1])
