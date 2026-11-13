## Semgrep 1.185.0
p/java exit=0
p/kotlin exit=0
p/c exit=0
p/secrets exit=0
p/github-actions exit=0
p/insecure-transport exit=0
p/default exit=0
Findings: 63, by severity {'WARNING': 56, 'ERROR': 6, 'INFO': 1}; scan errors: 0

### Top rules
- github-actions-mutable-action-tag: 27
- use-of-md5: 14
- use-of-sha1: 6
- exported_activity: 5
- unencrypted-socket: 4
- run-shell-injection: 2
- detected-generic-secret: 2
- detected-facebook-oauth: 1
- gcm-detection: 1
- command-injection-process-builder: 1

### ERROR-severity findings
- `.github/workflows/adhoc-signed-build.yml:36` run-shell-injection
- `.github/workflows/adhoc-signed-build.yml:39` run-shell-injection
- `app/src/androidTest/assets/test-v3-manifest.json:1` detected-facebook-oauth
- `app/src/main/java/app/gamenative/service/epic/EpicConstants.kt:107` detected-generic-secret
- `app/src/main/java/app/gamenative/service/gog/GOGConstants.kt:31` detected-generic-secret
- `app/src/main/java/com/winlator/core/ProcessHelper.java:215` command-injection-process-builder

### WARNING-severity (first 60)
- `.github/workflows/adhoc-signed-build.yml:31` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:46` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:52` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:54` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:168` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:174` github-actions-mutable-action-tag
- `.github/workflows/adhoc-signed-build.yml:180` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:25` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:34` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:40` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:42` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:150` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:156` github-actions-mutable-action-tag
- `.github/workflows/app-release-signed.yml:162` github-actions-mutable-action-tag
- `.github/workflows/issues-contributors-only.yml:14` github-actions-mutable-action-tag
- `.github/workflows/pluvia-pr-check.yml:24` github-actions-mutable-action-tag
- `.github/workflows/pluvia-pr-check.yml:26` github-actions-mutable-action-tag
- `.github/workflows/pluvia-pr-check.yml:45` github-actions-mutable-action-tag
- `.github/workflows/pluvia-pr-check.yml:47` github-actions-mutable-action-tag
- `.github/workflows/pluvia-pr-check.yml:51` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:19` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:22` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:29` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:32` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:145` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:158` github-actions-mutable-action-tag
- `.github/workflows/tagged-release.yml:170` github-actions-mutable-action-tag
- `app/src/main/java/com/winlator/steampipeserver/SteamPipeServer.java:32` unencrypted-socket
- `app/src/main/java/com/winlator/xenvironment/components/WineRequestComponent.java:45` unencrypted-socket
- `app/src/main/java/app/gamenative/service/SteamAutoCloud.kt:132` use-of-sha1
- `app/src/main/java/app/gamenative/service/ea/EaCloudSavesManager.kt:442` use-of-md5
- `app/src/main/java/app/gamenative/service/ea/EaCloudSyncApi.kt:145` use-of-md5
- `app/src/main/java/app/gamenative/service/epic/EpicDownloadManager.kt:794` use-of-sha1
- `app/src/main/java/app/gamenative/service/epic/EpicDownloadManager.kt:969` use-of-sha1
- `app/src/main/java/app/gamenative/service/epic/EpicDownloadManager.kt:1003` use-of-sha1
- `app/src/main/java/app/gamenative/service/epic/manifest/EpicManifest.kt:144` use-of-sha1
- `app/src/main/java/app/gamenative/service/gog/GOGBonusDlcInstaller.kt:291` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGCloudSavesManager.kt:60` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGCloudSavesManager.kt:96` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGDownloadManager.kt:1008` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGDownloadManager.kt:2073` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGDownloadManager.kt:2213` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGDownloadManager.kt:2327` use-of-md5
- `app/src/main/java/app/gamenative/service/gog/GOGDownloadManager.kt:2399` use-of-md5
- `app/src/main/java/app/gamenative/service/rockstar/RockstarCloudApi.kt:134` use-of-md5
- `app/src/main/java/app/gamenative/service/rockstar/RockstarCloudCompression.kt:29` use-of-md5
- `app/src/main/java/app/gamenative/service/rockstar/RockstarCloudCompression.kt:75` use-of-md5
- `app/src/main/java/app/gamenative/service/rockstar/RockstarCloudSavesManager.kt:457` use-of-md5
- `app/src/main/java/app/gamenative/utils/CloudSaveBackupManager.kt:478` use-of-sha1
- `app/src/legacyXr/AndroidManifest.xml:63` exported_activity
- `app/src/main/AndroidManifest.xml:65` exported_activity
- `app/src/main/AndroidManifest.xml:183` exported_activity
- `app/src/main/AndroidManifest.xml:195` exported_activity
- `app/src/main/java/app/gamenative/service/ea/EaLsxServer.kt:66` unencrypted-socket
- `app/src/main/java/app/gamenative/ui/screen/xr/windows/WindowsVrControlServer.kt:29` unencrypted-socket
- `app/src/modernXr/AndroidManifest.xml:58` exported_activity
