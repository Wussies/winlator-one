## Static checks: `target`

### Pattern hits (count — first 8 locations)
- **exec: Runtime.exec / ProcessBuilder**: 17
  - `app/src/main/java/app/gamenative/SteamBootstrap.kt:136: val pb = ProcessBuilder(`
  - `app/src/main/java/app/gamenative/SteamBootstrap.kt:208: val process = ProcessBuilder(readelfPath, "-s", systemSqlitePath)`
  - `app/src/main/java/app/gamenative/CrashHandler.kt:49: process = Runtime.getRuntime().exec(logcatCommand(lineCount))`
  - `app/src/main/java/app/gamenative/CrashHandler.kt:77: val process = Runtime.getRuntime().exec("logcat -d -t $LOG_CAT_COUNT --pid=${android.os.Process.myPid()}")`
  - `app/src/main/java/app/gamenative/utils/DebugReportUtils.kt:86: Runtime.getRuntime().exec(arrayOf("logcat", "-c")).waitFor()`
  - `app/src/main/java/app/gamenative/utils/DebugReportUtils.kt:87: logcatProcess = ProcessBuilder("logcat", "-v", "threadtime")`
  - `app/src/main/java/app/gamenative/display/GamescopeScalingCommand.kt:42: val process = ProcessBuilder(command)`
  - `app/src/main/java/app/gamenative/service/gog/GogGalaxyService.kt:114: val builder = ProcessBuilder(command.args)`
- **exec: native system/popen/exec***: 17
  - `app/src/main/java/app/gamenative/ui/model/UserLoginViewModel.kt:181: // From credential screen, back press is handled by the system (exits app)`
  - `app/src/main/cpp/proot/src/execve/exit.c:117: * auxiliary vectors of the previous execve(2).  */`
  - `app/src/main/cpp/proot/src/execve/exit.c:427: * extra SIGTRAP to the tracee after execve(2)`
  - `app/src/main/cpp/proot/src/execve/exit.c:461: * CLONE_VM so it has been sharing the heap with its parent. execve()`
  - `app/src/main/cpp/proot/src/tracee/event.c:87: * the next execve(2) so PRoot wouldn't handle the`
  - `app/src/main/cpp/proot/src/tracee/event.c:96: * guest rootfs.  Note: Valgrind can't handle execve(2) on`
  - `app/src/main/cpp/proot/src/tracee/event.c:97: * "foreign" binaries (ENOEXEC) but can handle execvp(3) on such`
  - `app/src/main/cpp/proot/src/tracee/event.c:99: execvp(tracee->exe, argv[0] != NULL ? argv : default_argv);`
- **dynamic code: DexClassLoader / InMemoryDex**: 0
- **dynamic native: System.load / dlopen**: 42
  - `app/src/main/java/app/gamenative/PluviaApp.kt:470: System.load(path)`
  - `app/src/main/java/app/gamenative/PluviaApp.kt:474: Timber.w(e, "[PluviaApp]: System.load($path) failed")`
  - `app/src/main/java/app/gamenative/display/GameNativeDrm.kt:14: System.loadLibrary("gamenative_drm")`
  - `app/src/main/java/app/gamenative/ui/screen/xr/XrNative.kt:16: System.loadLibrary("xrimmersive")`
  - `app/src/main/java/app/gamenative/service/download/GameDownloadNative.kt:19: System.loadLibrary(LIB_NAME)`
  - `app/src/main/java/app/gamenative/powercontrol/TaskAffinity.kt:20: val loaded = libraryLoaded ?: runCatching { System.loadLibrary("gnaffinity") }`
  - `app/src/main/java/app/gamenative/powercontrol/metrics/MaliGpuCounters.kt:167: System.loadLibrary("gncounters")`
  - `app/src/main/java/com/winlator/xserver/Drawable.java:51: System.loadLibrary("winlator_11");`
- **webview: addJavascriptInterface**: 4
  - `app/src/main/java/app/gamenative/ui/screen/auth/RockstarOAuthActivity.kt:368: * addJavascriptInterface only takes effect on the NEXT page load, so`
  - `app/src/main/java/app/gamenative/ui/screen/auth/RockstarOAuthActivity.kt:376: view.addJavascriptInterface(Bridge(), BRIDGE)`
  - `app/src/main/java/app/gamenative/service/WishlistWebViewAdder.kt:89: webView.addJavascriptInterface(`
  - `app/src/main/java/app/gamenative/service/rockstar/RockstarSignInShim.kt:9: * @BRIDGE@ (the name of the object exposed with addJavascriptInterface).`
- **webview: file access enabled**: 0
- **tls: trust-all / hostname bypass**: 0
- **cleartext http:// URL**: 17
  - `app/src/main/java/app/gamenative/service/ea/EaCloudSyncApi.kt:56: const val MANIFEST_XMLNS = "http://origin.com/cloudsaves/manifest"`
  - `app/src/main/java/app/gamenative/service/amazon/AmazonConstants.kt:30: const val OPENID_NS = "http://specs.openid.net/auth/2.0"`
  - `app/src/main/java/app/gamenative/service/amazon/AmazonConstants.kt:31: const val OPENID_NS_PAPE = "http://specs.openid.net/extensions/pape/1.0"`
  - `app/src/main/java/app/gamenative/service/amazon/AmazonConstants.kt:32: const val OPENID_NS_OA2 = "http://www.amazon.com/ap/ext/oauth/2"`
  - `app/src/main/java/app/gamenative/service/amazon/AmazonConstants.kt:34: const val OPENID_CLAIMED_ID = "http://specs.openid.net/auth/2.0/identifier_select"`
  - `app/src/main/java/app/gamenative/service/amazon/AmazonConstants.kt:35: const val OPENID_IDENTITY = "http://specs.openid.net/auth/2.0/identifier_select"`
  - `app/src/main/cpp/gn-download/rust/src/queue_delay.rs:261: connect_target("http://host:8080/x"),`
  - `app/src/main/cpp/gn-download/rust/src/store_dl/amazon.rs:758: assert_eq!(host_key("http://h:8080/x"), "http://h:8080");`
- **secrets in logs (password/token logged)**: 1
  - `app/src/main/java/app/gamenative/service/SteamService.kt:971: Timber.d("resolveDlcIdsForApp appId=$appId picsAccessToken=${accessToken != 0L}")`
- **base64 blob (>200 chars)**: 1
  - `app/src/main/java/app/gamenative/workshop/WorkshopManager.kt:89: private const val SLAY_THE_SPIRE_HEADLESS_LAUNCHER_JAR_BASE64 = "UEsDBAoAAAgAAG+AzlwAAAAAAAAAAAAAAAAJAAQATUVUQS1JTkYv/soAAFBLAwQUAAgICABvgM5cAAAAAAAAAAAAAAAAFAAAAE1FVEEtSU5GL01BTkl`
- **analytics/telemetry SDK**: 97
  - `app/build.gradle.kts:23: // Add PostHog API key and host as build-time variables`
  - `app/build.gradle.kts:24: val posthogApiKey: String = project.findProperty("POSTHOG_API_KEY") as String? ?: System.getenv("POSTHOG_API_KEY") ?: ""`
  - `app/build.gradle.kts:25: val posthogHost: String = project.findProperty("POSTHOG_HOST") as String? ?: System.getenv("POSTHOG_HOST") ?: "https://us.i.posthog.com"`
  - `app/build.gradle.kts:516: // Add PostHog Android SDK dependency`
  - `app/build.gradle.kts:517: implementation("com.posthog:posthog-android:3.8.0")`
  - `app/src/main/java/app/gamenative/MainActivity.kt:63: import com.posthog.PostHog`
  - `app/src/main/java/app/gamenative/MainActivity.kt:604: PostHog.capture(event = "app_foregrounded")`
  - `app/src/main/java/app/gamenative/MainActivity.kt:633: PostHog.capture(event = "app_backgrounded")`
- **LD_PRELOAD / library injection**: 18
  - `tools/build-gamenative-dns.sh:2: # Builds libgamenative_dns_v4mapped.so (the LD_PRELOAD DNS shim for bionic Wine`
  - `app/src/main/java/com/winlator/box86_64/rc/RCField.java:59: BOX64_LD_PRELOAD("BOX64_LD_PRELOAD", false),`
  - `app/src/main/java/com/winlator/container/ContainerOverlay.java:137: envVars.put("LD_PRELOAD", appendPreload(envVars.get("LD_PRELOAD"), lib.getAbsolutePath(), ":"));`
  - `app/src/main/java/com/winlator/xenvironment/components/GlibcProgramLauncherComponent.java:201: // LD_PRELOAD targets the native (ARM) dynamic linker. Since box64 is an ARM64 binary,`
  - `app/src/main/java/com/winlator/xenvironment/components/GlibcProgramLauncherComponent.java:205: // If box86 were used as a separate process, it would need its own LD_PRELOAD via its`
  - `app/src/main/java/com/winlator/xenvironment/components/GlibcProgramLauncherComponent.java:218: Log.d("GlibcProgramLauncherComponent", "Setting LD_PRELOAD=" + ldPreload);`
  - `app/src/main/java/com/winlator/xenvironment/components/GlibcProgramLauncherComponent.java:219: envVars.put("LD_PRELOAD", ldPreload.toString());`
  - `app/src/main/java/com/winlator/xenvironment/components/GlibcProgramLauncherComponent.java:313: // LD_PRELOAD targets the native ARM64 linker (see execGuestProgram for full explanation).`
- **chmod / setExecutable**: 66
  - `app/src/main/java/app/gamenative/utils/LsfgVkManager.kt:476: if (libFile.exists()) FileUtils.chmod(libFile, 0b111101101)`
  - `app/src/main/java/app/gamenative/utils/LsfgVkManager.kt:477: if (manifestFile.exists()) FileUtils.chmod(manifestFile, 0b110100100)`
  - `app/src/main/java/app/gamenative/utils/LsfgVkManager.kt:478: if (versionFile.exists()) FileUtils.chmod(versionFile, 0b110100100)`
  - `app/src/main/java/app/gamenative/utils/LsfgVkManager.kt:511: if (dllFile.exists()) FileUtils.chmod(dllFile, 0b110100100)`
  - `app/src/main/java/app/gamenative/utils/LsfgVkManager.kt:699: FileUtils.chmod(tmp, 0b110100100)`
  - `app/src/main/java/app/gamenative/utils/SteamTokenLogin.kt:219: FileUtils.chmod(File(steamConfigDir.absolutePathString(), "loginusers.vdf"), 505) // 0771`
  - `app/src/main/java/app/gamenative/utils/SteamTokenLogin.kt:220: FileUtils.chmod(File(steamConfigDir.absolutePathString(), "config.vdf"), 505) // 0771`
  - `app/src/main/java/app/gamenative/utils/SteamTokenLogin.kt:280: FileUtils.chmod(File(localSteamDir.absolutePathString(), "local.vdf"), 505) // 0771`
- **package spoofing (other apps' ids)**: 0
- **Steam API emulator (gbe_fork/Goldberg/ColdClient)**: 169
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:55: internal data class ColdClientLaunchConfig(`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:364: generateAchievementsFile(rootPath.resolve("steam_settings"), appId)`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:379: syncSteamInputActionSets(container, steamAppId, File(steamRootDir, "steam_settings").toPath())`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:473: internal fun generateColdClientIni(`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:482: val sanitizedExecutablePath = sanitizeColdClientArgumentText(executablePath)`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:483: val sanitizedExeCommandLine = sanitizeColdClientArgumentText(exeCommandLine)`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:484: val sanitizedExeRunDirOverride = exeRunDirOverride?.let(::sanitizeColdClientArgumentText)`
  - `app/src/main/java/app/gamenative/utils/SteamUtils.kt:520: internal fun resolveColdClientLaunchConfig(`

### Android permissions requested

- android.permission.ACCESS_MEDIA_LOCATION (x1)
- android.permission.ACCESS_NETWORK_STATE (x1)
- android.permission.ACCESS_WIFI_STATE (x1)
- android.permission.BLUETOOTH (x1)
- android.permission.BLUETOOTH_ADMIN (x1)
- android.permission.BLUETOOTH_CONNECT (x1)
- android.permission.FOREGROUND_SERVICE (x1)
- android.permission.FOREGROUND_SERVICE_DATA_SYNC (x1)
- android.permission.INTERNET (x1)
- android.permission.MANAGE_EXTERNAL_STORAGE (x2)
- android.permission.MODIFY_AUDIO_SETTINGS (x1)
- android.permission.POST_NOTIFICATIONS (x2)
- android.permission.READ_EXTERNAL_STORAGE (x4)
- android.permission.READ_LOGS (x2)
- android.permission.READ_MEDIA_AUDIO (x1)
- android.permission.READ_MEDIA_IMAGES (x1)
- android.permission.READ_MEDIA_VIDEO (x1)
- android.permission.READ_MEDIA_VISUAL_USER_SELECTED (x1)
- android.permission.READ_PHONE_STATE (x1)
- android.permission.RECORD_AUDIO (x2)
- android.permission.REQUEST_INSTALL_PACKAGES (x3)
- android.permission.VIBRATE (x1)
- android.permission.WRITE_EXTERNAL_STORAGE (x4)

### Exported components (6)

- app/src/legacyXr/AndroidManifest.xml: app.gamenative.ui.screen.xr.ImmersiveXrActivity
- app/src/modernXr/AndroidManifest.xml: app.gamenative.ui.screen.xr.ImmersiveXrActivity
- app/src/main/AndroidManifest.xml: .MainActivity
- app/src/main/AndroidManifest.xml: .ui.screen.auth.NexusOAuthCallbackActivity
- app/src/main/AndroidManifest.xml: .MainActivityAliasDefault
- app/src/main/AndroidManifest.xml: .MainActivityAliasAlt

### CI workflow review

- .github/workflows/tagged-release.yml: action not pinned to SHA: actions/checkout@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: actions/setup-java@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: gradle/actions/wrapper-validation@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: gradle/actions/setup-gradle@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: actions/download-artifact@v4
- .github/workflows/tagged-release.yml: action not pinned to SHA: softprops/action-gh-release@v2
- .github/workflows/tagged-release.yml: uses secrets (19 refs)
- .github/workflows/app-release-signed.yml: action not pinned to SHA: actions/checkout@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: actions/setup-java@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: gradle/actions/wrapper-validation@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: gradle/actions/setup-gradle@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/app-release-signed.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/app-release-signed.yml: uses secrets (19 refs)
- .github/workflows/pluvia-pr-check.yml: action not pinned to SHA: actions/checkout@v4
- .github/workflows/pluvia-pr-check.yml: action not pinned to SHA: actions/setup-java@v4
- .github/workflows/pluvia-pr-check.yml: action not pinned to SHA: gradle/actions/wrapper-validation@v4
- .github/workflows/pluvia-pr-check.yml: action not pinned to SHA: gradle/actions/setup-gradle@v4
- .github/workflows/pluvia-pr-check.yml: action not pinned to SHA: actions/cache@v4
- .github/workflows/pluvia-pr-check.yml: uses secrets (2 refs)
- .github/workflows/issues-contributors-only.yml: action not pinned to SHA: actions/github-script@v7
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: actions/checkout@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: actions/setup-java@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: gradle/actions/wrapper-validation@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: gradle/actions/setup-gradle@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/adhoc-signed-build.yml: action not pinned to SHA: actions/upload-artifact@v4
- .github/workflows/adhoc-signed-build.yml: uses secrets (18 refs)

### Binary inventory

Top-level binary files: {'ZIP': 10, 'ELF': 63, 'PE': 16, 'ZSTD': 85, 'XZ': 1}
Files found inside extracted archives: {'PE': 776, 'ELF': 146, 'DEX': 4, 'ZIP': 1}

| path | type | MB | sha256 |
|---|---|---|---|
| app/src/legacy/assets/extras.tzst | ZSTD | 86.0 | `d47d2c0e12f4f59b…` |
| app/src/legacy/assets/container_pattern_common.tzst | ZSTD | 41.6 | `c62311ac7a10a149…` |
| tools/bundletool-all-1.17.2.jar | ZIP | 32.5 | `2d4ad908faea6404…` |
| app/src/legacy/assets/wincomponents/direct3d.tzst | ZSTD | 31.2 | `149d55436e050bfa…` |
| app/src/legacy/assets/SD8Elite_800.35.zip | ZIP | 16.6 | `1852a2655da8dce7…` |
| app/src/legacy/assets/graphics_driver/adrenotools-v762.tzst | ZSTD | 16.5 | `c786b45d7f02310c…` |
| app/src/legacy/assets/SD8Elite_800.51.zip | ZIP | 15.9 | `774af41a2d993f5e…` |
| app/src/legacy/assets/SD8Elite_2-842.6.zip | ZIP | 13.3 | `4b6ee8eeac109800…` |
| app/src/legacy/assets/Adreno_819.2_adpkg.zip | ZIP | 13.1 | `d0c3ea86f4b681bd…` |
| app/src/legacy/assets/Adreno_805_adpkg.zip | ZIP | 12.8 | `7eebc20b44f10d84…` |
| app/src/legacy/assets/graphics_driver/adrenotools-v805.tzst | ZSTD | 12.2 | `81ff78581eb9acc3…` |
| app/src/main/jniLibs/arm64-v8a/libcomet.so | ELF | 11.5 | `c88517b8cd893b2c…` |
| app/src/legacy/assets/graphics_driver/extra_libs.tzst | ZSTD | 10.6 | `5808942d2426630a…` |
| app/src/legacy/assets/proton-9.0-arm64ec_container_pattern.tzst | ZSTD | 10.3 | `9826ac61405f641c…` |
| app/src/main/assets/dxwrapper/dxvk-async-1.10.3.tzst | ZSTD | 10.1 | `6c60805d22386b62…` |
| app/src/legacy/assets/container_pattern_gamenative.tzst | ZSTD | 9.9 | `f19a9e7280df753c…` |
| app/src/main/assets/dxwrapper/dxvk-2.4.1-gplasync.tzst | ZSTD | 9.1 | `7684a19e733310f9…` |
| app/src/legacy/assets/dxwrapper/dxvk-2.4.1.tzst | ZSTD | 9.1 | `f827bf18ef42d90b…` |
| app/src/legacy/jniLibs/arm64-v8a/libpatchelf.so | ELF | 9.0 | `8888caf11b0515fa…` |
| app/src/legacy/assets/proton-9.0-x86_64_container_pattern.tzst | ZSTD | 8.7 | `fa25987a3ba4f1b9…` |
| app/src/legacy/assets/wincomponents/opengl.tzst | ZSTD | 8.2 | `efe27f0de6a55bfb…` |
| app/src/legacy/assets/graphics_driver/zink_dlls.tzst | ZSTD | 8.2 | `efe27f0de6a55bfb…` |
| app/src/legacy/assets/dxwrapper/dxvk-1.10.3.tzst | ZSTD | 7.5 | `b337191462864958…` |
| app/src/main/assets/steampipe/steam_api64.dll | PE | 7.3 | `513430ac8b869b0e…` |
| app/src/legacy/assets/dxwrapper/dxvk-1.10.1.tzst | ZSTD | 6.7 | `a1de22b82bdec1a0…` |
| app/src/legacy/assets/wincomponents/openal.tzst | ZSTD | 6.3 | `5e849dd182eb7361…` |
| app/src/main/assets/steampipe/steam_api.dll | PE | 5.9 | `4cc9dfcab8b4df0d…` |
| app/src/legacy/assets/graphics_driver/wrapper-legacy.tzst | ZSTD | 5.7 | `9e5b2539c1b86afd…` |
| app/src/legacy/assets/graphics_driver/wrapper-v2.tzst | ZSTD | 5.4 | `68bfa91d88d374b6…` |
| app/src/legacy/assets/dxwrapper/dxvk-2.7.1.tzst | ZSTD | 4.8 | `0255396bbedeec6d…` |
| app/src/main/assets/dxwrapper/dxvk-2.6.1-gplasync.tzst | ZSTD | 4.7 | `b397293f0018a063…` |
| app/src/main/assets/box86_64/box64-0.3.6.tzst | ZSTD | 4.6 | `6daf984e45f399ab…` |
| app/src/main/assets/box86_64/box64-0.3.8.tzst | ZSTD | 4.2 | `aeee651f759abcff…` |
| app/src/main/assets/box86_64/box64-0.4.0-bionic.tzst | ZSTD | 4.2 | `6c8fbe61b322f06d…` |
| app/src/main/assets/box86_64/box64-0.3.4.tzst | ZSTD | 4.0 | `a60addf559d2284d…` |
| app/src/legacy/assets/dxwrapper/vkd3d-3.0b.tzst | ZSTD | 4.0 | `fdace3d5894af70f…` |
| app/src/main/jniLibs/arm64-v8a/libgndownload.so | ELF | 3.9 | `b66f8689b624bd0f…` |
| app/src/legacy/assets/graphics_driver/wrapper.tzst | ZSTD | 3.8 | `2005169d30ab7558…` |
| app/src/legacy/assets/graphics_driver/zink-22.2.5.tzst | ZSTD | 3.7 | `5231f32412a9d973…` |
| app/src/legacy/assets/dxwrapper/dxvk-1.10.9-sarek.tzst | ZSTD | 3.7 | `1fdcb03b08eacb28…` |
| app/src/main/assets/box86_64/box64-0.3.8-bionic.tzst | ZSTD | 3.6 | `e254bff766fa61c5…` |
| app/src/main/assets/dxwrapper/dxvk-1.11.1-sarek.tzst | ZSTD | 3.6 | `ce37f7d779e1f9ec…` |
| app/src/main/assets/box86_64/box64-0.4.2-bionic.tzst | ZSTD | 3.5 | `fcd10730ff899bad…` |
| app/src/main/assets/fexcore/fexcore-2601.tzst | ZSTD | 3.5 | `418a30180d7272e1…` |
| app/src/main/assets/fexcore/fexcore-2512.tzst | ZSTD | 3.5 | `171466bb8eef6b49…` |
| app/src/main/assets/fexcore/fexcore-2511.tzst | ZSTD | 3.4 | `9ee55e7d6570146d…` |
| app/src/legacy/assets/dxwrapper/dxvk-1.9.2.tzst | ZSTD | 3.3 | `c535a7376e404267…` |
| app/src/legacy/assets/graphics_driver/virgl-23.1.9.tzst | ZSTD | 3.3 | `6ed76575a2489443…` |
| app/src/legacy/assets/graphics_driver/adrenotools-turnip26.0.0_R4.tzst | ZSTD | 3.2 | `ed1104cbf4387e28…` |
| app/src/main/assets/fexcore/fexcore-2508.tzst | ZSTD | 3.1 | `49bbd4effd80a715…` |
| app/src/legacy/assets/graphics_driver/adrenotools-turnip25.3.0_R11.tzst | ZSTD | 3.1 | `2af295136d29ee40…` |
| app/src/main/assets/box86_64/box64-0.3.6-bionic.tzst | ZSTD | 3.1 | `3ba2cb63473b3a65…` |
| app/src/legacy/assets/graphics_driver/libvulkan_wrapper.tar.xz | XZ | 3.1 | `e634370220234bdd…` |
| app/src/main/jniLibs/arm64-v8a/libfossilize_replay.so | ELF | 3.0 | `2e0396eca90a40c3…` |
| app/src/main/assets/box86_64/box64-0.3.7-bionic.tzst | ZSTD | 3.0 | `ce95d5b352eaceaa…` |
| app/src/main/assets/box86_64/box64-0.3.2-bionic.tzst | ZSTD | 3.0 | `a93c1cd4a050a168…` |
| app/src/legacyXr/assets/opencomposite_x86.dll | PE | 2.7 | `86a77b58c817ed0b…` |
| app/src/modernXr/assets/opencomposite_x86.dll | PE | 2.7 | `86a77b58c817ed0b…` |
| app/src/legacy/assets/wincomponents/wmdecoder.tzst | ZSTD | 2.7 | `49a9f29fa099d456…` |
| app/src/main/jniLibs/arm64-v8a/liblsfg-vk-layer.so | ELF | 2.6 | `09b085213732ff41…` |

### Declared dependencies: 69 (full list in deps.txt)
