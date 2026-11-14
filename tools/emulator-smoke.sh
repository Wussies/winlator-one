#!/usr/bin/env bash
# NEXORA emulator smoke test: install the APK, open the setup wizard, press
# "Install System Files" like a user would, and wait for the real result.
#
# usage: tools/emulator-smoke.sh <apk> <output-dir>
# Exit 0 only when the app logs a completed ImageFS installation and is still
# alive. Any crash (Java or native), JNI abort, failure message or timeout = 1.
set -u
PKG=io.github.wussies.nexora
APK="$1"
OUT="$2"
TIMEOUT_S="${SMOKE_TIMEOUT_S:-1500}"
HERE="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$OUT"

log() { echo "[smoke] $*" | tee -a "$OUT/steps.txt"; }

adb wait-for-device
for i in $(seq 1 120); do
  [ "$(adb shell getprop sys.boot_completed | tr -d '\r')" = "1" ] && break
  sleep 2
done
adb shell getprop ro.build.version.release | tr -d '\r' > "$OUT/android-version.txt"
adb shell getprop ro.product.cpu.abilist | tr -d '\r' > "$OUT/abilist.txt"
adb shell getprop ro.dalvik.vm.native.bridge | tr -d '\r' > "$OUT/native-bridge.txt"
log "Android $(cat "$OUT/android-version.txt"), ABIs $(cat "$OUT/abilist.txt"), native bridge $(cat "$OUT/native-bridge.txt")"
adb shell df -h /data | tee "$OUT/df-before.txt"

log "installing $(basename "$APK")"
if ! adb install -r -g "$APK" > "$OUT/install.txt" 2>&1; then
  cat "$OUT/install.txt"; log "RESULT: APK install failed"; exit 1
fi
adb shell appops set "$PKG" MANAGE_EXTERNAL_STORAGE allow || true

adb logcat -c
adb logcat -v threadtime > "$OUT/logcat.txt" 2>&1 &
LOGCAT_PID=$!
trap 'kill $LOGCAT_PID 2>/dev/null' EXIT

log "launching"
adb shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1

tapped=0
start=$(date +%s)
result=""
while :; do
  now=$(date +%s); elapsed=$((now - start))
  if grep -qE "FATAL EXCEPTION|JNI DETECTED ERROR|Fatal signal [0-9]+|Abort message" "$OUT/logcat.txt"; then
    result="CRASH"; break
  fi
  if grep -q "ImageFsInstaller: ImageFS [0-9]* installed" "$OUT/logcat.txt"; then
    result="INSTALLED"; break
  fi
  if grep -q "ImageFsInstaller: Install failed" "$OUT/logcat.txt"; then
    result="FAILED"; break
  fi
  if [ "$elapsed" -gt "$TIMEOUT_S" ]; then result="TIMEOUT"; break; fi
  if [ "$tapped" = 1 ] && [ -z "$(adb shell pidof "$PKG" | tr -d '\r')" ]; then
    sleep 3
    grep -qE "ImageFsInstaller: ImageFS [0-9]* installed" "$OUT/logcat.txt" && { result="INSTALLED"; break; }
    result="PROCESS_DIED"; break
  fi

  if [ "$tapped" = 0 ]; then
    adb exec-out uiautomator dump /dev/tty 2>/dev/null | sed 's/UI hierchary dumped.*//' > "$OUT/ui.xml"
    action=$(python3 -I "$HERE/emulator-ui.py" "$OUT/ui.xml")
    case "$action" in
      tap-install\ *)
        set -- $action; adb shell input tap "$2" "$3"; tapped=1
        log "tapped Install System Files at $2,$3 after ${elapsed}s"
        # Double press: must not start a second installation.
        sleep 1; adb shell input tap "$2" "$3"; log "pressed it a second time" ;;
      tap-dismiss\ *)
        set -- $action; adb shell input tap "$2" "$3"; log "dismissed a dialog ($4)" ;;
      *) : ;;
    esac
    sleep 3
  else
    sleep 10
  fi
done

adb shell df -h /data | tee "$OUT/df-after.txt"
adb exec-out screencap -p > "$OUT/final.png" 2>/dev/null || true
adb exec-out uiautomator dump /dev/tty 2>/dev/null | sed 's/UI hierchary dumped.*//' > "$OUT/ui-final.xml"
grep -E "ImageFsInstaller|NativeContentIO|TarCompressorUtils|AndroidRuntime|DEBUG|libc|JNI" "$OUT/logcat.txt" > "$OUT/logcat-relevant.txt" || true

starts=$(grep -c "ImageFsInstaller: ImageFS [0-9]* installed" "$OUT/logcat.txt" || true)
if [ "$result" = "INSTALLED" ] && [ "$starts" != "1" ]; then result="DUPLICATE_INSTALL ($starts)"; fi
log "evidence: installer log lines"
grep -E "ImageFsInstaller|NativeContentIO" "$OUT/logcat.txt" | sed 's/^/  /' | tail -n 20 | tee -a "$OUT/steps.txt"
button=$(python3 -I - "$OUT/ui-final.xml" <<'PY'
import sys, xml.etree.ElementTree as ET
try:
    root = ET.fromstring(open(sys.argv[1], encoding="utf-8", errors="ignore").read().strip())
    texts = [n.get("text") for n in root.iter("node") if n.get("text")]
    i = [t.lower() for t in texts].index("install system files")
    print(" | ".join(texts[i:i + 4]))
except Exception as e:
    print(f"(not found: {e})")
PY
)
log "evidence: system-files card now shows: $button"
if [ "$result" != "INSTALLED" ]; then
  log "RESULT: system files $result"
  tail -n 80 "$OUT/logcat-relevant.txt"
  exit 1
fi
log "RESULT: system files INSTALLED"

# ---- Phase 2: wizard -> Next -> Next -> "Install All Recommended" (pinned components) ----
tap_label() {  # tap_label <label>  -> 0 when tapped
  adb exec-out uiautomator dump /dev/tty 2>/dev/null | sed 's/UI hierchary dumped.*//' > "$OUT/ui.xml"
  local action; action=$(python3 -I "$HERE/emulator-ui.py" "$OUT/ui.xml" "$1")
  case "$action" in
    tap-install\ *) set -- $action; adb shell input tap "$2" "$3"; return 0 ;;
    tap-dismiss\ *) set -- $action; adb shell input tap "$2" "$3"; log "dismissed a dialog ($4)"; return 1 ;;
  esac
  return 1
}
sleep 3
found=0
for step in 1 2 3 4 5 6; do
  if tap_label "Install All Recommended"; then found=1; log "tapped Install All Recommended"; break; fi
  tap_label "Next" && log "tapped Next" || true
  sleep 4
done
if [ "$found" = 0 ]; then
  log "RESULT: components FAILED (Install All Recommended not reachable)"
  python3 -I - "$OUT/ui.xml" <<'PY' | tee -a "$OUT/steps.txt"
import sys, xml.etree.ElementTree as ET
r = ET.fromstring(open(sys.argv[1], encoding="utf-8", errors="ignore").read().strip() or "<x/>")
print("visible texts:", [n.get("text") for n in r.iter("node") if n.get("text")][:40])
PY
  exit 1
fi
cstart=$(date +%s)
while :; do
  if grep -qE "FATAL EXCEPTION|JNI DETECTED ERROR|Fatal signal [0-9]+|Abort message" "$OUT/logcat.txt"; then cres="CRASH"; break; fi
  if grep -q "SetupWizardActivity: Install queue finished" "$OUT/logcat.txt"; then cres="FINISHED"; break; fi
  [ $(( $(date +%s) - cstart )) -gt 1800 ] && { cres="TIMEOUT"; break; }
  [ -z "$(adb shell pidof "$PKG" | tr -d '\r')" ] && { cres="PROCESS_DIED"; break; }
  sleep 10
done
ok=$(grep -c "SetupWizardActivity: Component installed:" "$OUT/logcat.txt" || true)
bad=$(grep -c "SetupWizardActivity: Component install failed:" "$OUT/logcat.txt" || true)
log "evidence: components"
grep -E "SetupWizardActivity: Component|NexoraComponentPins|Integrity check" "$OUT/logcat.txt" | sed 's/^/  /' | tee -a "$OUT/steps.txt"
adb exec-out screencap -p > "$OUT/final-components.png" 2>/dev/null || true
if [ "$cres" = "FINISHED" ] && [ "$ok" -gt 0 ] && [ "$bad" = 0 ]; then
  log "RESULT: components INSTALLED ($ok) after $(( $(date +%s) - cstart ))s"
  exit 0
fi
log "RESULT: components $cres (installed $ok, failed $bad)"
tail -n 80 "$OUT/logcat-relevant.txt"
exit 1
