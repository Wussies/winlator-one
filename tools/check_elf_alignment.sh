#!/usr/bin/env bash
# Reports the ELF LOAD segment alignment of every native library inside an APK.
# Output is Markdown (written to the GitHub job summary in CI).
#
# Why: Android 15+ supports devices with 16 KB memory pages. Libraries aligned
# only to 4 KB cannot be loaded on such devices (Android 16 has a compat mode).
# The OnePlus 13 kernel currently uses 4 KB pages, so this is informational,
# not a build failure. See docs/STAGE0_RESEARCH.md, risk R6.
set -euo pipefail

APK="${1:?usage: check_elf_alignment.sh <file.apk>}"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

unzip -q -o "$APK" 'lib/*' -d "$WORK" || true

echo "### Native library alignment (16 KB page readiness)"
echo
echo "| Library | LOAD align | 16 KB ready |"
echo "|---|---|---|"

ok=0; bad=0
while IFS= read -r so; do
  align=$(readelf -lW "$so" 2>/dev/null | awk '$1=="LOAD"{print $NF}' | sort -u | head -n1)
  [ -z "$align" ] && align="?"
  if [ "$align" != "?" ] && [ $((align)) -ge 16384 ]; then
    ready="yes"; ok=$((ok+1))
  else
    ready="no"; bad=$((bad+1))
  fi
  echo "| $(basename "$so") | $align | $ready |"
done < <(find "$WORK/lib" -name '*.so' | sort)

echo
echo "**$ok ready, $bad not 16 KB aligned.**"
