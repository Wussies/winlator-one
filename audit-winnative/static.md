## Static checks: `target`

### Pattern hits (count — first 8 locations)
- **exec: Runtime.exec / ProcessBuilder**: 12
  - `app/src/androidTest/kotlin/com/winlator/cmod/runtime/linux/LinuxRuntimeTest.kt:29: val proot = ProcessBuilder(asked)`
  - `app/src/main/runtime/display/framegen/SystemFrameGenDetector.kt:246: val process = ProcessBuilder(command).redirectErrorStream(true).start()`
  - `app/src/main/runtime/display/environment/components/GuestProgramLauncherComponent.java:746: process = Runtime.getRuntime().exec(new String[] {"ldd", curlPath});`
  - `app/src/main/runtime/display/environment/components/LinuxProgramLauncherComponent.java:56: ProcessBuilder builder = new ProcessBuilder(command).directory(workingDir);`
  - `app/src/main/runtime/display/environment/components/PulseAudioComponent.java:325: Runtime.getRuntime().exec(pactl.getAbsolutePath() + " " + command, envp, workingDir);`
  - `app/src/main/runtime/system/ProcessHelper.java:353: ProcessBuilder pb = new ProcessBuilder(splitCommand);`
  - `app/src/main/runtime/system/LogManager.kt:435: Runtime.getRuntime().exec(`
  - `app/src/main/runtime/system/LogManager.kt:478: Runtime.getRuntime().exec(`
- **exec: native system/popen/exec***: 34
  - `tools/linuxfs/preload/net.c:197: int execve(const char *path, char *const argv[], char *const envp[]) {`
  - `tools/linuxfs/preload/net.c:204: /* popen(3) and posix_spawn(3) reach lsof without going through the execve symbol above. The`
  - `tools/linuxfs/preload/net.c:221: int execvp(const char *file, char *const argv[]) {`
  - `tools/linuxfs/preload/net.c:228: int execv(const char *path, char *const argv[]) {`
  - `app/src/main/rust/wn-steam-tools/src/bin/winnative_steamwebhelper_wrapper.rs:188: libc::execv(target_c.as_ptr(), ptrs.as_ptr());`
  - `app/src/main/cpp/proot/src/execve/shebang.c:219: *  argument of execve() specifies an interpreter script, then`
  - `app/src/main/cpp/proot/src/execve/shebang.c:225: * argument of execve()." -- man 2 execve`
  - `app/src/main/cpp/proot/src/execve/shebang.c:269: *     execve("./script", { "script.sh", NULL }, ...)`
- **dynamic code: DexClassLoader / InMemoryDex**: 0
- **dynamic native: System.load / dlopen**: 56
  - `framegen/src/main/java/com/winlator/cmod/shared/framegen/FrameGenNative.kt:13: runCatching { System.loadLibrary("c++_shared") }`
  - `framegen/src/main/java/com/winlator/cmod/shared/framegen/FrameGenNative.kt:14: loaded = runCatching { System.loadLibrary("winlator") }.isSuccess`
  - `app/src/androidTest/kotlin/org/winnative/steam/SteamWiredPipelineTest.kt:54: System.loadLibrary("SDL3steam")`
  - `app/src/androidTest/kotlin/org/winnative/steam/SteamWiredPipelineTest.kt:55: System.loadLibrary("steamctrl")`
  - `app/src/androidTest/kotlin/com/winlator/cmod/runtime/input/SteamControllerNativeTest.kt:26: System.loadLibrary("SDL3steam")`
  - `app/src/androidTest/kotlin/com/winlator/cmod/runtime/input/SteamControllerNativeTest.kt:27: System.loadLibrary("steamctrl")`
  - `app/src/main/runtime/display/xserver/Drawable.java:30: System.loadLibrary("winlator");`
  - `app/src/main/runtime/display/xserver/Drawable.java:463: //        System.loadLibrary("winlator");`
- **webview: addJavascriptInterface**: 0
- **webview: file access enabled**: 0
- **tls: trust-all / hostname bypass**: 0
- **cleartext http:// URL**: 5
  - `tools/linuxfs/build-linuxfs.sh:111: [ -s "pkgs/$gtk2_deb" ] || curl -fsSLo "pkgs/$gtk2_deb" "http://deb.debian.org/debian/pool/main/g/gtk+2.0/$gtk2_deb"`
  - `app/src/main/runtime/display/XServerDisplayActivity.java:9830: + "      <activeCodePage xmlns=\"http://schemas.microsoft.com/SMI/2019/WindowsSettings\">"`
  - `app/src/main/cpp/proot/src/tracee/event.c:263: "http://static.proot.me/proot-x86_64");`
  - `app/src/main/cpp/wn-steam-client/rust/src/cdn_client.rs:259: "http://{}/appinfo/{}/sha/{}.txt.gz",`
  - `app/src/main/cpp/wn-steam-client/rust/src/cdn_client.rs:583: "http://cache1.steamcontent.com/appinfo/601150/sha/abcd01.txt.gz"`
- **secrets in logs (password/token logged)**: 1
  - `app/src/main/runtime/linux/LinuxEpicTokens.kt:107: Log.w(TAG, "a caller without the session's secret was refused")`
- **base64 blob (>200 chars)**: 0
- **analytics/telemetry SDK**: 0
- **LD_PRELOAD / library injection**: 24
  - `tools/test-fakeinput.sh:66: adb -s "$serial" shell "LD_LIBRARY_PATH=$device_dir LD_PRELOAD=$device_dir/libfakeinput.so $device_dir/directaudio_input_test $device_dir/libwaudio.so"`
  - `tools/linuxfs/preload/storage.c:8: * LD_PRELOAD cannot see direct syscalls or libc-internal calls that bypass public symbols. A`
  - `tools/linuxfs/preload/sysv.c:5: * LD_PRELOADed into the session and keeps each object in a file under /dev/shm (a bound directory`
  - `app/src/main/runtime/display/XServerDisplayActivity.java:9029: // the Steam client rebuilds LD_PRELOAD for every process it starts and appends its overlay`
  - `app/src/main/runtime/display/environment/components/GuestProgramLauncherComponent.java:386: "execShellCommand LD_PRELOAD setup: sysvshm="`
  - `app/src/main/runtime/display/environment/components/GuestProgramLauncherComponent.java:397: envVars.put("LD_PRELOAD", ldPreload.toString());`
  - `app/src/main/runtime/display/environment/components/GuestProgramLauncherComponent.java:398: Log.d("GuestLauncher", "execShellCommand LD_PRELOAD=" + ldPreload.toString());`
  - `app/src/main/runtime/display/environment/components/GuestProgramLauncherComponent.java:403: envVars.get("LD_PRELOAD"),`
- **chmod / setExecutable**: 47
  - `tools/linuxfs/fastpath/fastpath.c:1226: int chmod(const char *path, mode_t mode) { return fchmodat(AT_FDCWD, path, mode, 0); }`
  - `tools/linuxfs/tests/test_proton.py:106: wine.chmod(0o755)`
  - `tools/linuxfs/tests/test_proton.py:109: proton.chmod(0o755)`
  - `tools/linuxfs/tests/test_proton.py:112: audio.chmod(0o755)`
  - `app/src/main/runtime/container/ContainerManager.java:118: "chmod", "-R", "0771", new File(containerDir, ".wine/drive_c").getAbsolutePath()`
  - `app/src/main/runtime/container/ContainerManager.java:400: FileUtils.chmod(file, 0771);`
  - `app/src/main/runtime/display/XServerDisplayActivity.java:8913: scriptFile.setExecutable(true);`
  - `app/src/main/runtime/display/XServerDisplayActivity.java:12891: com.winlator.cmod.shared.io.FileUtils.chmod(steamlessCli, 0755);`
- **package spoofing (other apps' ids)**: 10
  - `app/build.gradle:285: applicationId "com.ludashi.benchmark"`
  - `app/build.gradle:290: applicationId "com.tencent.ig"`
  - `app/build.gradle:295: applicationId "com.antutu.ABenchMark"`
  - `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m0_setup.py:3: PREFIX = "/data/data/com.tencent.ig/files/imagefs/home/xuser-3/.wine"`
  - `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m0_setup.py:7: CONTAINER = "/data/data/com.tencent.ig/files/imagefs/home/xuser-3/.container"`
  - `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m0_setup.py:8: PREFS = "/data/data/com.tencent.ig/shared_prefs/steam_prefs.xml"`
  - `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m2b_setup.py:2: PREFIX = "/data/data/com.tencent.ig/files/imagefs/home/xuser-3/.wine"`
  - `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m2b_setup.py:3: IMAGEFS = "/data/data/com.tencent.ig/files/imagefs"`
- **Steam API emulator (gbe_fork/Goldberg/ColdClient)**: 218
  - `tools/update-gbe-fork.sh:3: # update-gbe-fork.sh — refresh the bundled ColdClient / gbe_fork emulator.`
  - `tools/update-gbe-fork.sh:6: # pinned) gbe_fork Windows release published at:`
  - `tools/update-gbe-fork.sh:7: #   https://github.com/Detanup01/gbe_fork/releases`
  - `tools/update-gbe-fork.sh:20: REPO="Detanup01/gbe_fork"`
  - `tools/update-gbe-fork.sh:23: VERSION_FILE="$ROOT/tools/gbe_fork.version"`
  - `tools/update-gbe-fork.sh:26: # gbe_fork download), so a gbe_fork bump can't swap it — but a bad merge, tampering, or`
  - `tools/update-gbe-fork.sh:43: echo "Target gbe_fork release: $TAG"`
  - `tools/update-gbe-fork.sh:56: # Stage the ColdClient files under the Wine-prefix layout the extractor expects.`

### Android permissions requested

- android.permission.ACCESS_NETWORK_STATE (x1)
- android.permission.ACCESS_WIFI_STATE (x1)
- android.permission.BLUETOOTH (x1)
- android.permission.BLUETOOTH_ADMIN (x1)
- android.permission.BLUETOOTH_CONNECT (x1)
- android.permission.BLUETOOTH_SCAN (x1)
- android.permission.CHANGE_WIFI_MULTICAST_STATE (x1)
- android.permission.FOREGROUND_SERVICE (x1)
- android.permission.FOREGROUND_SERVICE_DATA_SYNC (x1)
- android.permission.FOREGROUND_SERVICE_SPECIAL_USE (x1)
- android.permission.HIGH_SAMPLING_RATE_SENSORS (x1)
- android.permission.INTERNET (x1)
- android.permission.MANAGE_EXTERNAL_STORAGE (x1)
- android.permission.MODIFY_AUDIO_SETTINGS (x1)
- android.permission.POST_NOTIFICATIONS (x1)
- android.permission.READ_EXTERNAL_STORAGE (x1)
- android.permission.RECORD_AUDIO (x1)
- android.permission.REQUEST_INSTALL_PACKAGES (x1)
- android.permission.SYSTEM_ALERT_WINDOW (x1)
- android.permission.VIBRATE (x1)
- android.permission.WAKE_LOCK (x1)
- android.permission.WRITE_EXTERNAL_STORAGE (x1)
- android.permission.WRITE_SECURE_SETTINGS (x1)
- com.android.launcher.permission.INSTALL_SHORTCUT (x1)

### Exported components (5)

- app/src/main/AndroidManifest.xml: com.winlator.cmod.app.shell.UnifiedActivity
- app/src/main/AndroidManifest.xml: com.winlator.cmod.runtime.display.XServerDisplayActivity
- app/src/main/AndroidManifest.xml: com.winlator.cmod.feature.shortcuts.ShortcutBroadcastReceiver
- app/src/main/AndroidManifest.xml: com.winlator.cmod.app.provider.WinlatorFilesProvider
- dolphin/src/main/AndroidManifest.xml: org.dolphinemu.dolphinemu.wn.DolphinEmulationActivity

### CI workflow review

- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/checkout@v6
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/setup-java@v5
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: gradle/actions/setup-gradle@v6
- .github/workflows/tag-apk-artifacts.yml: action not pinned to SHA: actions/upload-artifact@v7
- .github/workflows/tag-apk-artifacts.yml: uses secrets (4 refs)
- .github/workflows/release.yml: action not pinned to SHA: actions/checkout@v6
- .github/workflows/release.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/release.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/release.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/release.yml: action not pinned to SHA: actions/setup-java@v5
- .github/workflows/release.yml: action not pinned to SHA: gradle/actions/setup-gradle@v6
- .github/workflows/release.yml: action not pinned to SHA: actions/upload-artifact@v7
- .github/workflows/release.yml: action not pinned to SHA: actions/checkout@v6
- .github/workflows/release.yml: uses secrets (10 refs)
- .github/workflows/pr-release-publish.yml: uses secrets (10 refs)
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/checkout@v6
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/cache@v5
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/setup-java@v5
- .github/workflows/pr-ci.yml: action not pinned to SHA: gradle/actions/setup-gradle@v6
- .github/workflows/pr-ci.yml: action not pinned to SHA: actions/upload-artifact@v7
- .github/workflows/pr-ci.yml: uses secrets (6 refs)

### Binary inventory

Top-level binary files: {'PE': 20, 'ZIP': 11, 'ELF': 36, 'ZSTD': 36}
Files found inside extracted archives: {'PE': 620, 'ELF': 65, 'ZIP': 9}

| path | type | MB | sha256 |
|---|---|---|---|
| app/src/main/assets/container_pattern_common.tzst | ZSTD | 41.6 | `6f5a7b011f2ab79d…` |
| app/src/main/assets/wincomponents/direct3d.tzst | ZSTD | 31.2 | `149d55436e050bfa…` |
| app/src/debug/jniLibs/arm64-v8a/libVkLayer_khronos_validation.so | ELF | 24.6 | `a11e2d33f8473fdc…` |
| app/src/main/assets/graphics_driver/extra_libs.tzst | ZSTD | 18.9 | `91cfbfb3366baafd…` |
| app/src/main/assets/steampipe/steam_api64.dll | PE | 18.1 | `b06a34b865d532a9…` |
| vendor/maven/org/libsdl/android/SDL3/3.4.16/SDL3-3.4.16.aar | ZIP | 16.9 | `03710fc7b49cc070…` |
| app/src/main/assets/steampipe/steam_api.dll | PE | 16.2 | `6439aa6b3574de7c…` |
| app/src/main/assets/wnsteam/bionic/valve-steam-x86_64.tzst | ZSTD | 16.0 | `b827a4cedc5f27ac…` |
| app/src/main/assets/linuxfs/usr/lib/libvulkan_freedreno.so | ELF | 15.7 | `007d008631275f66…` |
| app/src/main/assets/experimental-drm.tzst | ZSTD | 15.5 | `cc95e069d6221d9f…` |
| app/src/main/assets/wnsteam/steam-androidarm64.tzst | ZSTD | 12.8 | `3bc6825d9ea95f93…` |
| app/src/main/assets/proton-9.0-arm64ec_container_pattern.tzst | ZSTD | 10.3 | `9826ac61405f641c…` |
| armsx2/src/main/jniLibs/arm64-v8a/liblibrashader_capi.so | ELF | 10.0 | `6575c8594932dc88…` |
| app/src/main/assets/ffmpeg8.tzst | ZSTD | 8.8 | `e19acae70b1e1890…` |
| app/src/main/assets/proton-9.0-x86_64_container_pattern.tzst | ZSTD | 8.7 | `fa25987a3ba4f1b9…` |
| app/src/main/assets/container_pattern.tzst | ZSTD | 8.3 | `4043fa27127c6634…` |
| app/src/main/assets/graphics_driver/zink_dlls.tzst | ZSTD | 8.2 | `efe27f0de6a55bfb…` |
| app/src/main/assets/wnsteam/steampipe/original_steam_api64.dll | PE | 7.3 | `513430ac8b869b0e…` |
| app/src/main/assets/graphics_driver/zink-22.2.5.tzst | ZSTD | 7.1 | `8a1de929cda4699d…` |
| armsx2/src/main/jniLibs/arm64-v8a/libshaderc_shared.so | ELF | 6.6 | `e9c9d2799e9588d9…` |
| app/src/main/assets/graphics_driver/virgl-23.1.9.tzst | ZSTD | 6.4 | `c42f22641079f678…` |
| armsx2/src/main/jniLibs/arm64-v8a/libGLESv2_angle.so | ELF | 6.3 | `def0973783d540aa…` |
| app/src/main/assets/wnsteam/steampipe/steam_api.dll | PE | 5.9 | `4cc9dfcab8b4df0d…` |
| app/src/main/assets/wnsteam/lsteamclient-arm64ec.tzst | ZSTD | 5.8 | `b34d9ffdc8d88451…` |
| vendor/maven/org/libsdl/android/SDL3/3.4.16-winnative.2/SDL3-3.4.16-winnative.2.aar | ZIP | 4.8 | `4a2c8bf5f3913991…` |
| vendor/maven/org/libsdl/android/SDL3/3.4.16-winnative.1/SDL3-3.4.16-winnative.1.aar | ZIP | 4.8 | `b7cb9d22b91e1888…` |
| app/src/main/assets/layers.tzst | ZSTD | 4.4 | `9beac20c3e2c7f2c…` |
| app/src/main/assets/linuxfs/usr/local/bin/gamescope | ELF | 4.2 | `9618408a1a8fad74…` |
| app/src/main/assets/wnsteam/lsteamclient-x86_64.tzst | ZSTD | 4.1 | `e998f6c950606d63…` |
| app/src/main/assets/graphics_driver/wrapper.tzst | ZSTD | 3.8 | `718b6b22647d1246…` |
| app/src/main/assets/wnsteam/bionic/steamservice.dll | PE | 3.7 | `7b6730263a0ee9fe…` |
| app/src/main/assets/graphics_driver/wrapper-leegao.tzst | ZSTD | 3.1 | `3eabf6fc53f3b738…` |
| app/src/main/assets/ddrawrapper/dd7to9.tzst | ZSTD | 3.0 | `a35490ac6acb63c7…` |
| app/src/main/assets/wnsteam/bionic/steamservice.exe | PE | 3.0 | `eeed0d75b1e5f4bd…` |
| app/src/main/assets/wincomponents/xaudio.tzst | ZSTD | 2.7 | `128ab3f25a74ff37…` |
| armsx2/src/main/jniLibs/arm64-v8a/libSPIRV-Tools-shared.so | ELF | 2.6 | `e0137464504ed91c…` |
| app/src/main/assets/extras.tzst | ZSTD | 2.4 | `46217601a80e16ca…` |
| app/src/main/assets/winnative/Graphics-Test-64bit.exe | PE | 2.4 | `3aecfa2c3adadae8…` |
| app/src/main/assets/winnative/Graphics-Test-32bit.exe | PE | 2.3 | `e721234b7bcf1d60…` |
| app/src/main/assets/wincomponents/directshow.tzst | ZSTD | 2.2 | `aa682b7ee6e5903e…` |
| app/src/main/assets/xvfb-arm64/Xvfb | ELF | 2.1 | `1aaaefd376c73197…` |
| app/src/main/assets/dxwrapper/d8vk-1.0.tzst | ZSTD | 1.9 | `da30a104f83f6192…` |
| app/src/main/assets/wincomponents/wmdecoder.tzst | ZSTD | 1.7 | `a2ca365cc4326568…` |
| app/src/main/assets/ddrawrapper/ddraw-11.8.tzst | ZSTD | 1.6 | `92e6a19232dd3908…` |
| app/src/main/assets/wnsteam/bionic/steam32.exe | PE | 1.3 | `8b1aba7f8e5dd82e…` |
| app/src/main/assets/ddrawrapper/nglide.tzst | ZSTD | 1.2 | `3f5eb40810376cdb…` |
| app/src/main/assets/wnsteam/bionic/steam.exe | PE | 1.2 | `c454075e89dfdff0…` |
| app/src/main/assets/wincomponents/vcrun2010.tzst | ZSTD | 1.0 | `9def7b4b5c31c839…` |
| app/src/main/assets/xvfb-arm64/winnative-driverquery-noop | ELF | 0.9 | `bbedfe5e93b42402…` |
| app/src/main/assets/xvfb-arm64/winnative-steamwebhelper-wrapper | ELF | 0.9 | `654b9a4f2d8f3035…` |
| app/src/main/assets/graphics_driver/wrapper-gamenative.tzst | ZSTD | 0.8 | `e38683ac1d382dc8…` |
| app/src/main/assets/ddrawrapper/ddraw-4.21.tzst | ZSTD | 0.7 | `06d073dc65ab89d1…` |
| app/src/main/jniLibs/arm64-v8a/libpulsecore-13.0.so | ELF | 0.6 | `1bbfb039b159da9b…` |
| app/src/main/assets/wnsteam/steampipe/steam_api64.dll | PE | 0.5 | `d4e3a74fbec39bde…` |
| app/src/main/jniLibs/arm64-v8a/libsndfile.so | ELF | 0.5 | `d6b61f5dddedce3c…` |
| app/src/main/jniLibs/arm64-v8a/libpulsecommon-13.0.so | ELF | 0.5 | `febdaa6fb344775f…` |
| app/src/main/assets/wincomponents/directsound.tzst | ZSTD | 0.4 | `72f0e880eef1387a…` |
| app/src/main/assets/wincomponents/directplay.tzst | ZSTD | 0.4 | `70eb81449230af66…` |
| app/src/main/assets/xvfb-arm64/libpixman-1.so.0.40.0 | ELF | 0.4 | `e1dfb301bdc6b510…` |
| app/libs/MidiSynth/MidiSynth.jar | ZIP | 0.3 | `d00423610e59335e…` |

### Declared dependencies: 51 (full list in deps.txt)
