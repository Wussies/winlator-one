#!/usr/bin/env bash
# Downloads the large runtime archives listed in tools/components.lock and
# refuses to continue unless every file matches its pinned SHA-256 and size.
# Usage: tools/fetch-components.sh [base-url]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_URL="${1:-https://github.com/Wussies/winlator-one/releases/download/nexora-components-1}"
LOCK="$ROOT/tools/components.lock"

grep -v '^\s*#' "$LOCK" | grep -v '^\s*$' | while read -r name sha size dest; do
  target="$ROOT/$dest"
  if [ -f "$target" ] && echo "$sha  $target" | sha256sum -c --status; then
    echo "ok (cached): $name"
    continue
  fi
  mkdir -p "$(dirname "$target")"
  echo "downloading: $name"
  curl -fL --retry 3 --proto '=https' --tlsv1.2 -o "$target.part" "$BASE_URL/$name"
  actual_size=$(stat -c %s "$target.part")
  if [ "$actual_size" != "$size" ]; then
    echo "ERROR: $name size $actual_size != $size" >&2; rm -f "$target.part"; exit 1
  fi
  if ! echo "$sha  $target.part" | sha256sum -c --status; then
    echo "ERROR: $name SHA-256 mismatch" >&2; rm -f "$target.part"; exit 1
  fi
  mv "$target.part" "$target"
  echo "verified: $name"
done
