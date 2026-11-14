# MobSF static analysis

Security score: 41, trackers: 0

## Scorecard — high (4)
- Activity (com.winlator.cmod.app.shell.UnifiedActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- The App uses ECB mode in Cryptographic encryption algorithm. ECB mode is known to be weak as it results in the same ciphertext for identical blocks of plaintext.: The App uses ECB mode in Cryptographic encryption algorithm. ECB mode is known to be weak as it results in the same ciphertext for identical blocks of plaintext.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0
- The App uses the encryption mode CBC with PKCS5/PKCS7 padding. This configuration is vulnerable to padding oracle attacks.: The App uses the encryption mode CBC with PKCS5/PKCS7 padding. This configuration is vulnerable to padding oracle attacks.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#identifyin

## Scorecard — warning (16)
- App can be installed on a vulnerable Android version 8.0, minSdk=26]: This application can be installed on an older version of android that has multiple vulnerabilities. Support an Android version => 10, API 29 to receive reasonable security updates.
- Content Provider (com.winlator.cmod.app.provider.WinlatorFilesProvider) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.MANAGE_DOCUMENTS [android:exported=true]: A Content Provider is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applicat
- Service (androidx.work.impl.background.systemjob.SystemJobService) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.BIND_JOB_SERVICE [android:exported=true]: A Service is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed application. As a
- Broadcast Receiver (androidx.work.impl.diagnostics.DiagnosticsReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applic
- Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is not Protected. [android:exported=true]: An Activity is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Broadcast Receiver (androidx.profileinstaller.ProfileInstallReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applic
- App can read/write to External Storage. Any App can read data written to External Storage.: App can read/write to External Storage. Any App can read data written to External Storage.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#external-storage

Files:
com/winlator/cmod
- Files may contain hardcoded sensitive information like usernames, passwords, keys etc.: Files may contain hardcoded sensitive information like usernames, passwords, keys etc.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#checking-memory-for-sensitive-data-mstg-storag
- App creates temp file. Sensitive information should never be written into a temp file.: App creates temp file. Sensitive information should never be written into a temp file.


Files:
com/github/luben/zstd/util/Native.java, line(s) 125
com/winlator/cmod/feature/stores/itch/service/ItchDownloadManager.java, 
- SHA-1 is a weak hash known to have hash collisions.: SHA-1 is a weak hash known to have hash collisions.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#identifying-insecure-andor-deprecated-cryptographic-algorithms-mstg-crypto-4

Fil
- IP Address disclosure: IP Address disclosure


Files:
com/winlator/cmod/feature/stores/gog/service/GOGCloudSavesManager.java, line(s) 50
com/winlator/cmod/feature/stores/itch/service/ItchConstants.java, line(s) 26
com/winlator/cmod/feature/sto
- MD5 is a weak hash known to have hash collisions.: MD5 is a weak hash known to have hash collisions.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#identifying-insecure-andor-deprecated-cryptographic-algorithms-mstg-crypto-4

Files
- The App uses an insecure Random Number Generator.: The App uses an insecure Random Number Generator.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#weak-random-number-generators

Files:
J7/b.java, line(s) 13
p056g6/a.java, line(s) 
- LocalServerSocket has no built-in authentication. Any app on the device can connect to this abstract-namespace UNIX domain socket. Require an authentication handshake before honoring commands received on it.: LocalServerSocket has no built-in authentication. Any app on the device can connect to this abstract-namespace UNIX domain socket. Require an authentication handshake before honoring commands received on it.
https://deve
- App uses SQLite Database and execute raw SQL query. Untrusted user input in raw SQL queries can cause SQL Injection. Also sensitive information should be encrypted and written to the database.: App uses SQLite Database and execute raw SQL query. Untrusted user input in raw SQL queries can cause SQL Injection. Also sensitive information should be encrypted and written to the database.
https://github.com/MobSF/ow
- This app may contain hardcoded secrets: The following secrets were identified from the app. Ensure that these are not secrets or private information.
"device_profile_feature_session_menu" : "ขนาดปุ่มเมนูในเกม"
"device_profile_feature_session_menu" : "ゲーム内メニューボ

## Scorecard — info (3)
- The App logs information. Sensitive information should never be logged.: The App logs information. Sensitive information should never be logged.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#logs

Files:
A1/f.java, line(s) 1219,1395,1415,1427
A4/a.java
- This app listens to Clipboard changes. Some malware also listen to Clipboard changes.: This app listens to Clipboard changes. Some malware also listen to Clipboard changes.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04b-Mobile-App-Security-Testing.md#clipboard

Files:
com/winlator/cmod/runt
- This App copies data to clipboard. Sensitive data should not be copied to clipboard as other applications can access it.: This App copies data to clipboard. Sensitive data should not be copied to clipboard as other applications can access it.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04b-Mobile-App-Security-Testing.md#clipb

## Scorecard — secure (2)
- This App uses SSL certificate pinning to detect or  prevent MITM attacks in secure communication channel.: This App uses SSL certificate pinning to detect or  prevent MITM attacks in secure communication channel.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05g-Testing-Network-Communication.md#testing-custom-cer
- This application has no privacy trackers: This application does not include any user or device trackers. Unable to find trackers during static analysis.

## Scorecard — hotspot (1)
- Found 7 critical permission(s): Ensure that these permissions are required by the application.

android.permission.BLUETOOTH_CONNECT (dangerous): necessary for connecting to paired Bluetooth devices. - Required to be able to connect to paired Bluetooth

## Dangerous permissions
- android.permission.BLUETOOTH_CONNECT: Required to be able to connect to paired Bluetooth devices.
- android.permission.BLUETOOTH_SCAN: Required to be able to discover and pair nearby Bluetooth devices.
- android.permission.WRITE_EXTERNAL_STORAGE: Allows an application to write to external storage.
- android.permission.READ_EXTERNAL_STORAGE: Allows an application to read from external storage.
- android.permission.RECORD_AUDIO: Allows application to access the audio record path.
- android.permission.MANAGE_EXTERNAL_STORAGE: Allows an application a broad access to external storage in scoped storage. Intended to be used by few apps that need to manage files on behalf of the users.
- android.permission.POST_NOTIFICATIONS: Allows an app to post notifications

## Manifest analysis (high/warning)
- [warning] App can be installed on a vulnerable Android version 8.0, minSdk=26]
- [high] Activity (com.winlator.cmod.app.shell.UnifiedActivity) is vulnerable to StrandHogg 2.0
- [warning] Content Provider (com.winlator.cmod.app.provider.WinlatorFilesProvider) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.MANAG
- [warning] Service (androidx.work.impl.background.systemjob.SystemJobService) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.BIND_JOB_S
- [warning] Broadcast Receiver (androidx.work.impl.diagnostics.DiagnosticsReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP 
- [high] Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is vulnerable to StrandHogg 2.0
- [warning] Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is not Protected. [android:exported=true]
- [warning] Broadcast Receiver (androidx.profileinstaller.ProfileInstallReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [a

## Trackers
0

## APKiD (MobSF)
{"b13996f79d2def432c7f790925fcbd6d.apk": {"manipulator": ["Resources Confusion"], "packer": ["DexGuard"]}, "classes.dex": {"anti_vm": ["Build.FINGERPRINT check", "Build.MANUFACTURER check"], "compiler": ["r8"]}, "classes2.dex": {"anti_vm": ["Build.MANUFACTURER check", "Build.BOARD check"], "compiler": ["r8"]}, "lib/arm64-v8a/libproot-loader.so": {"anti_hook": ["syscalls"]}, "assets/linuxfs/usr/local/lib/libwnaudit.so": {"anti_hook": ["syscalls"]}, "assets/linuxfs/usr/local/lib/libwnfastpath.so": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/libwinnative-steamwebhelper-preload.so": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/winnative-driverquery-noop": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/winnative-steamwebhelper-wrapper": {"anti_hook": ["syscalls"]}}

## Domains contacted by code (malware-domain check)
- huggingface.co: bad=no
- epicgames.com: bad=no
- gamesdb.gog.com: bad=no
- www.reddit.com: bad=no
- cloudflare.epicgamescdn.com: bad=no
- schemas.microsoft.com: bad=no
- github.com: bad=no
- steamcommunity.com: bad=no
- www.epicgames.com: bad=no
- library-service.live.use1a.on.epicgames.com: bad=no
- api.github.com: bad=no
- dns.google: bad=no
- paypal.me: bad=no
- datastorage-public-service-liveegs.live.use1a.on.epicgames.com: bad=no
- account-public-service-prod.ol.epicgames.com: bad=no
- catalog-public-service-prod06.ol.epicgames.com: bad=no
- api.gog.com: bad=no
- www.freedesktop.org: bad=no
- store.steampowered.com: bad=no
- cloudstorage.gog.com: bad=no
- embed.gog.com: bad=no
- android.googlesource.com: bad=no
- shared.akamai.steamstatic.com: bad=no
- steamcdn-a.akamaihd.net: bad=no
- ns.adobe.com: bad=no
- discord.gg: bad=no
- content-system.gog.com: bad=no
- gog-cdn-fastly.gog.com: bad=no
- pcgamingwiki.com: bad=no
- commons.apache.org: bad=no
- goo.gle: bad=no
- www.steamgriddb.com: bad=no
- www.gog.com: bad=no
- images.gog.com: bad=no
- youtube.com: bad=no
- account-public-service-prod03.ol.epicgames.com: bad=no
- schemas.android.com: bad=no
- cdn.cloudflare.steamstatic.com: bad=no
- shared.steamstatic.com: bad=no
- auth.gog.com: bad=no
- dl.winehq.org: bad=no
- launcher-public-service-prod06.ol.epicgames.com: bad=no
- itch.io: bad=no
- client-update.fastly.steamstatic.com: bad=no
- raw.githubusercontent.com: bad=no
- ecommerceintegration-public-service-ecomprod02.ol.epicgames.com: bad=no
- remote-config.gog.com: bad=no
- fonts.gstatic.com: bad=no
- avatars.akamai.steamstatic.com: bad=no
- winnative.dev: bad=no
- docs.rs: bad=no
- developer.android.com: bad=no
