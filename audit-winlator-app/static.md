## Static checks: `target`

### Pattern hits (count — first 8 locations)
- **exec: Runtime.exec / ProcessBuilder**: 1
  - `app/src/main/java/com/winlator/core/ProcessHelper.java:73: ProcessBuilder processBuilder = (new ProcessBuilder(splitCommand(command))).directory(workingDir);`
- **exec: native system/popen/exec***: 0
- **dynamic code: DexClassLoader / InMemoryDex**: 0
- **dynamic native: System.load / dlopen**: 25
  - `app/src/main/java/com/winlator/xserver/Drawable.java:28: System.loadLibrary("winlator");`
  - `app/src/main/java/com/winlator/xserver/extensions/GLXExtension.java:41: System.loadLibrary("gladiorenderer");`
  - `app/src/main/java/com/winlator/core/GPUHelper.java:34: System.loadLibrary("winlator");`
  - `app/src/main/java/com/winlator/core/WineRegistryEditor.java:30: System.loadLibrary("winlator");`
  - `app/src/main/java/com/winlator/winhandler/MIDIHandler.java:57: System.loadLibrary("midihandler");`
  - `app/src/main/java/com/winlator/renderer/GPUImage.java:19: System.loadLibrary("winlator");`
  - `app/src/main/java/com/winlator/xconnector/XOutputStream.java:16: System.loadLibrary("winlator");`
  - `app/src/main/java/com/winlator/xconnector/XInputStream.java:13: System.loadLibrary("winlator");`
- **webview: addJavascriptInterface**: 0
- **webview: file access enabled**: 0
- **tls: trust-all / hostname bypass**: 0
- **cleartext http:// URL**: 0
- **secrets in logs (password/token logged)**: 0
- **base64 blob (>200 chars)**: 0
- **analytics/telemetry SDK**: 3
  - `app/src/main/java/com/winlator/inputcontrols/GamepadVibration.java:72: private short parseAmplitude(int motorSpeed) {`
  - `app/src/main/java/com/winlator/inputcontrols/GamepadVibration.java:88: short speedX = parseAmplitude(leftMotorSpeed);`
  - `app/src/main/java/com/winlator/inputcontrols/GamepadVibration.java:89: short speedY = parseAmplitude(rightMotorSpeed);`
- **LD_PRELOAD / library injection**: 1
  - `app/src/main/cpp/libadrenotools/lib/linkernsbypass/android_linker_ns.h:63: * @note IMPORTANT: If  filename  is compiled with the '-z global' linker flag and RTLD_GLOBAL is supplied in  flags  the library will be added to the namespace's LD_PRELOAD list`
- **chmod / setExecutable**: 10
  - `app/src/main/java/com/winlator/core/ZipUtils.java:95: FileUtils.chmod(file, 0771);`
  - `app/src/main/java/com/winlator/core/ZipUtils.java:122: FileUtils.chmod(file, 0771);`
  - `app/src/main/java/com/winlator/core/FileUtils.java:261: public static void chmod(File file, int mode) {`
  - `app/src/main/java/com/winlator/core/FileUtils.java:263: Os.chmod(file.getAbsolutePath(), mode);`
  - `app/src/main/java/com/winlator/core/WineUtils.java:36: FileUtils.chmod(driveX, 0771);`
  - `app/src/main/java/com/winlator/core/WineUtils.java:49: FileUtils.chmod(linkTarget, 0771);`
  - `app/src/main/java/com/winlator/core/TarCompressorUtils.java:176: FileUtils.chmod(file, 0771);`
  - `app/src/main/java/com/winlator/container/ContainerManager.java:133: if (!FileUtils.copy(srcContainer.getRootDir(), dstDir, (file) -> FileUtils.chmod(file, 0771))) {`
- **package spoofing (other apps' ids)**: 0
- **Steam API emulator (gbe_fork/Goldberg/ColdClient)**: 0

### Android permissions requested

- android.permission.ACCESS_NETWORK_STATE (x1)
- android.permission.ACCESS_WIFI_STATE (x1)
- android.permission.FOREGROUND_SERVICE (x1)
- android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK (x1)
- android.permission.INTERNET (x1)
- android.permission.MODIFY_AUDIO_SETTINGS (x1)
- android.permission.POST_NOTIFICATIONS (x1)
- android.permission.READ_EXTERNAL_STORAGE (x1)
- android.permission.VIBRATE (x1)
- android.permission.WAKE_LOCK (x1)
- android.permission.WRITE_EXTERNAL_STORAGE (x1)

### Exported components (1)

- app/src/main/AndroidManifest.xml: com.winlator.MainActivity

### CI workflow review

- no workflows / no findings

### Binary inventory

Top-level binary files: {'ZSTD': 25, 'ELF': 24, 'ZIP': 1}
Files found inside extracted archives: {'PE': 1910, 'ELF': 706, 'GZIP': 233}

| path | type | MB | sha256 |
|---|---|---|---|
| app/src/main/assets/rootfs.tzst | ZSTD | 65.3 | `aeea2938cc63b070…` |
| app/src/main/assets/wincomponents/direct3d.tzst | ZSTD | 31.2 | `149d55436e050bfa…` |
| app/src/main/assets/container_pattern.tzst | ZSTD | 7.4 | `8ae3a4fee33e86da…` |
| app/src/main/assets/box64/box64-0.4.4.tzst | ZSTD | 4.5 | `e1a34fed50bb38ef…` |
| app/src/main/assets/dxwrapper/dxvk-2.4.1.tzst | ZSTD | 4.3 | `897cc48500241006…` |
| app/src/main/assets/rootfs_patches.tzst | ZSTD | 4.2 | `49ab7a5158ef7ccf…` |
| app/src/main/assets/graphics_driver/zink-22.2.5.tzst | ZSTD | 3.9 | `b9fc365f894a4b83…` |
| app/src/main/assets/dxwrapper/dxvk-1.10.3.tzst | ZSTD | 3.6 | `18ed7c263e0d52c4…` |
| app/src/main/assets/graphics_driver/virgl-23.1.9.tzst | ZSTD | 3.5 | `614b1edc8e47c57b…` |
| app/src/main/assets/dxwrapper/d7vk-1.11.tzst | ZSTD | 2.8 | `c737c5ec4c6d4bbb…` |
| app/src/main/assets/wincomponents/xaudio.tzst | ZSTD | 2.7 | `128ab3f25a74ff37…` |
| app/src/main/assets/graphics_driver/turnip-26.2.0.tzst | ZSTD | 2.7 | `1e5bd643d64b4509…` |
| app/src/main/assets/dxwrapper/vkd3d-2.14.1.tzst | ZSTD | 2.4 | `354b43b84df13668…` |
| app/src/main/assets/wincomponents/directshow.tzst | ZSTD | 2.2 | `aa682b7ee6e5903e…` |
| app/src/main/jniLibs/arm64-v8a/libglib-2.0.so | ELF | 2.2 | `7f905fcffc568884…` |
| app/src/main/assets/dxwrapper/d8vk-1.0.tzst | ZSTD | 1.9 | `da30a104f83f6192…` |
| app/src/main/assets/wincomponents/wmdecoder.tzst | ZSTD | 1.7 | `a2ca365cc4326568…` |
| app/src/main/jniLibs/arm64-v8a/libgio-2.0.so | ELF | 1.6 | `9515ab32df670f32…` |
| app/src/main/jniLibs/arm64-v8a/libc++_shared.so | ELF | 1.3 | `df2767fb3f2fdb44…` |
| app/src/main/assets/wincomponents/vcrun2005.tzst | ZSTD | 1.2 | `6ae9f3c22fecbc5d…` |
| app/src/main/assets/wincomponents/vcrun2010.tzst | ZSTD | 1.0 | `9def7b4b5c31c839…` |
| app/src/main/jniLibs/arm64-v8a/libinstpatch-1.0.so | ELF | 0.8 | `2da0eabc3c8a85b1…` |
| app/src/main/jniLibs/arm64-v8a/libsndfile.so | ELF | 0.7 | `a499fbaadb35b594…` |
| app/src/main/jniLibs/arm64-v8a/libvorbisenc.so | ELF | 0.7 | `7207f7b9bd0a29be…` |
| app/src/main/jniLibs/arm64-v8a/libpulsecore-13.0.so | ELF | 0.6 | `364d57e94cd9dbd7…` |
| app/src/main/jniLibs/arm64-v8a/libpulsecommon-13.0.so | ELF | 0.5 | `96abf45e5981723d…` |
| app/src/main/jniLibs/arm64-v8a/libfluidsynth.so | ELF | 0.4 | `686104b19f2571d7…` |
| app/src/main/assets/wincomponents/directsound.tzst | ZSTD | 0.4 | `72f0e880eef1387a…` |
| app/src/main/assets/wincomponents/directplay.tzst | ZSTD | 0.4 | `70eb81449230af66…` |
| app/src/main/jniLibs/arm64-v8a/libopus.so | ELF | 0.4 | `54b64261a3dd521a…` |
| app/src/main/jniLibs/arm64-v8a/libgobject-2.0.so | ELF | 0.4 | `e9d65c3f65167269…` |
| app/src/main/assets/wincomponents/directmusic.tzst | ZSTD | 0.3 | `eb906732d1476664…` |
| app/src/main/jniLibs/arm64-v8a/libpulse.so | ELF | 0.3 | `db4dbb786d613ff0…` |
| app/src/main/jniLibs/arm64-v8a/liboboe.so | ELF | 0.3 | `777940c6d8f95b15…` |
| app/src/main/jniLibs/arm64-v8a/libFLAC.so | ELF | 0.2 | `029daf547f4d8914…` |
| app/src/main/jniLibs/arm64-v8a/libpcre.so | ELF | 0.2 | `b94c6ab513b6c628…` |
| app/src/main/jniLibs/arm64-v8a/libvorbis.so | ELF | 0.2 | `3a726f2c1e06a42b…` |
| app/src/main/assets/dxwrapper/cnc-ddraw-6.6/ddraw.tzst | ZSTD | 0.2 | `eabb2d59ce706076…` |
| app/src/main/assets/graphics_driver/vortek-2.1.tzst | ZSTD | 0.1 | `505e5089371d8698…` |
| app/src/main/jniLibs/arm64-v8a/libltdl.so | ELF | 0.1 | `e6c7a402a53b78ba…` |
| app/src/main/assets/graphics_driver/gladio-1.1.tzst | ZSTD | 0.1 | `925a492ca58d4670…` |
| app/src/main/jniLibs/arm64-v8a/libpulseaudio.so | ELF | 0.1 | `2f5dd7e2c828e570…` |
| gradle/wrapper/gradle-wrapper.jar | ZIP | 0.1 | `575098db54a998ff…` |
| app/src/main/assets/pulseaudio.tzst | ZSTD | 0.0 | `a31d331e1f1ec514…` |
| app/src/main/jniLibs/arm64-v8a/libvorbisfile.so | ELF | 0.0 | `fedcc9a3fd560ee5…` |
| app/src/main/jniLibs/arm64-v8a/libogg.so | ELF | 0.0 | `24d51cf112ec335c…` |
| app/src/main/jniLibs/arm64-v8a/libgmodule-2.0.so | ELF | 0.0 | `da0b26f148b0b406…` |
| app/src/main/jniLibs/arm64-v8a/libpcreposix.so | ELF | 0.0 | `c496d8515bba479d…` |
| app/src/main/jniLibs/arm64-v8a/libfluidsynth-assetloader.so | ELF | 0.0 | `01f10ba852da027f…` |
| app/src/main/jniLibs/arm64-v8a/libgthread-2.0.so | ELF | 0.0 | `3551751014caf5cd…` |

### Declared dependencies: 8 (full list in deps.txt)
