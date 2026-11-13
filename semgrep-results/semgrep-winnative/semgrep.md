## Semgrep 1.185.0
p/java exit=0
p/kotlin exit=0
p/c exit=0
p/secrets exit=0
p/github-actions exit=0
p/insecure-transport exit=0
p/default exit=0
Findings: 62, by severity {'WARNING': 52, 'ERROR': 10}; scan errors: 0

### Top rules
- github-actions-mutable-action-tag: 22
- use-of-md5: 10
- use-of-sha1: 8
- unencrypted-socket: 5
- subprocess-shell-true: 3
- exported_activity: 2
- detected-generic-secret: 2
- command-injection-process-builder: 2
- ifs-tampering: 2
- run-shell-injection: 1
- detected-jwt-token: 1
- bad-hexa-conversion: 1
- insecure-file-permissions: 1
- dynamic-urllib-use-detected: 1
- tarfile-extractall-traversal: 1

### ERROR-severity findings
- `.github/workflows/release.yml:340` run-shell-injection
- `app/src/androidTest/kotlin/com/winlator/cmod/runtime/system/LogShareTest.kt:15` detected-jwt-token
- `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m0_setup.py:56` subprocess-shell-true
- `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m2_setup.py:25` subprocess-shell-true
- `app/src/main/cpp/wn-steam-launcher/steamlite-handoff/reference-scripts/m2b_setup.py:27` subprocess-shell-true
- `app/src/main/feature/stores/epic/service/EpicConstants.kt:68` detected-generic-secret
- `app/src/main/feature/stores/gog/service/GOGConstants.kt:31` detected-generic-secret
- `app/src/main/runtime/display/environment/components/LinuxProgramLauncherComponent.java:56` command-injection-process-builder
- `app/src/main/runtime/system/ProcessHelper.java:353` command-injection-process-builder
- `tools/sdl/build_android_transport.py:43` tarfile-extractall-traversal

### WARNING-severity (first 60)
- `.github/workflows/pr-ci.yml:48` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:55` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:65` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:76` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:86` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:95` github-actions-mutable-action-tag
- `.github/workflows/pr-ci.yml:166` github-actions-mutable-action-tag
- `.github/workflows/release.yml:106` github-actions-mutable-action-tag
- `.github/workflows/release.yml:113` github-actions-mutable-action-tag
- `.github/workflows/release.yml:123` github-actions-mutable-action-tag
- `.github/workflows/release.yml:134` github-actions-mutable-action-tag
- `.github/workflows/release.yml:144` github-actions-mutable-action-tag
- `.github/workflows/release.yml:153` github-actions-mutable-action-tag
- `.github/workflows/release.yml:210` github-actions-mutable-action-tag
- `.github/workflows/release.yml:226` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:41` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:48` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:58` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:69` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:79` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:88` github-actions-mutable-action-tag
- `.github/workflows/tag-apk-artifacts.yml:134` github-actions-mutable-action-tag
- `app/src/main/AndroidManifest.xml:70` exported_activity
- `app/src/main/AndroidManifest.xml:110` exported_activity
- `app/src/main/feature/retro/Gen1EmbedLaunch.kt:23` use-of-sha1
- `app/src/main/feature/retro/RetroBiosImport.kt:26` use-of-md5
- `app/src/main/feature/retro/RetroNetplay.kt:946` unencrypted-socket
- `app/src/main/feature/retro/RetroNetplay.kt:990` unencrypted-socket
- `app/src/main/feature/steamcloudsync/SteamAutoCloud.kt:543` use-of-sha1
- `app/src/main/feature/stores/epic/service/EpicDownloadManager.kt:1263` use-of-sha1
- `app/src/main/feature/stores/epic/service/EpicDownloadManager.kt:1539` use-of-sha1
- `app/src/main/feature/stores/epic/service/EpicDownloadManager.kt:1574` use-of-sha1
- `app/src/main/feature/stores/epic/service/manifest/EpicManifest.kt:125` use-of-sha1
- `app/src/main/feature/stores/epic/service/manifest/ManifestUtils.kt:32` use-of-sha1
- `app/src/main/feature/stores/gog/service/GOGCloudSavesManager.kt:77` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGCloudSavesManager.kt:624` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGDownloadManager.kt:876` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGDownloadManager.kt:1526` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGDownloadManager.kt:1653` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGDownloadManager.kt:1750` use-of-md5
- `app/src/main/feature/stores/gog/service/GOGDownloadManager.kt:1778` use-of-md5
- `app/src/main/runtime/content/component/ComponentInstaller.kt:461` use-of-md5
- `app/src/main/runtime/display/steampipeserver/SteamPipeServer.java:43` unencrypted-socket
- `app/src/main/runtime/linux/LinuxEpicTokens.kt:68` unencrypted-socket
- `app/src/main/runtime/reshade/ReshadeDownloader.kt:94` use-of-md5
- `app/src/main/runtime/wine/WineRequestHandler.java:48` unencrypted-socket
- `app/src/main/runtime/wine/WineUtils.java:1691` bad-hexa-conversion
- `app/src/main/runtime/wine/WineUtils.java:1695` use-of-sha1
- `tools/linuxfs/overlay/usr/local/bin/winnative-directaudio:61` insecure-file-permissions
- `tools/linuxfs/overlay/usr/local/bin/winnative-proton-launch:60` ifs-tampering
- `tools/linuxfs/overlay/usr/local/bin/winnative-proton-launch:67` ifs-tampering
- `tools/sdl/build_android_transport.py:37` dynamic-urllib-use-detected
