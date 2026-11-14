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
if [ "$result" = "INSTALLED" ]; then
  log "RESULT: INSTALLED after $(( $(date +%s) - start ))s"
  exit 0
fi
log "RESULT: $result"
tail -n 80 "$OUT/logcat-relevant.txt"
exit 1
