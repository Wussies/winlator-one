# MobSF static analysis

Security score: 33, trackers: 0

## Scorecard — high (9)
- Debug Enabled For App [android:debuggable=true]: Debugging was enabled on the app which makes it easier for reverse engineers to hook a debugger to it. This allows dumping a stack trace and accessing debugging helper classes.
- Activity (com.winlator.cmod.app.shell.UnifiedActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Activity (com.winlator.cmod.runtime.display.XServerDisplayActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Activity (org.dolphinemu.dolphinemu.wn.DolphinEmulationActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Activity (androidx.activity.ComponentActivity) is vulnerable to StrandHogg 2.0: Activity is found to be vulnerable to StrandHogg 2.0 task hijacking vulnerability. When vulnerable, it is possible for other applications to place a malicious activity on top of the activity stack of the vulnerable appli
- Debug configuration enabled. Production builds must not be debuggable.: Debug configuration enabled. Production builds must not be debuggable.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04c-Tampering-and-Reverse-Engineering.md#debugging-and-tracing

Files:
com/armsx2/BuildCon
- The App uses ECB mode in Cryptographic encryption algorithm. ECB mode is known to be weak as it results in the same ciphertext for identical blocks of plaintext.: The App uses ECB mode in Cryptographic encryption algorithm. ECB mode is known to be weak as it results in the same ciphertext for identical blocks of plaintext.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0
- The App uses the encryption mode CBC with PKCS5/PKCS7 padding. This configuration is vulnerable to padding oracle attacks.: The App uses the encryption mode CBC with PKCS5/PKCS7 padding. This configuration is vulnerable to padding oracle attacks.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#identifyin

## Scorecard — warning (17)
- App can be installed on a vulnerable Android version 8.0, minSdk=26]: This application can be installed on an older version of android that has multiple vulnerabilities. Support an Android version => 10, API 29 to receive reasonable security updates.
- Activity (com.winlator.cmod.runtime.display.XServerDisplayActivity) is not Protected. [android:exported=true]: An Activity is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Broadcast Receiver (com.winlator.cmod.feature.shortcuts.ShortcutBroadcastReceiver) is not Protected. [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Content Provider (com.winlator.cmod.app.provider.WinlatorFilesProvider) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.MANAGE_DOCUMENTS [android:exported=true]: A Content Provider is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applicat
- Service (androidx.work.impl.background.systemjob.SystemJobService) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.BIND_JOB_SERVICE [android:exported=true]: A Service is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed application. As a
- Broadcast Receiver (androidx.work.impl.diagnostics.DiagnosticsReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applic
- Activity (org.dolphinemu.dolphinemu.wn.DolphinEmulationActivity) is not Protected. [android:exported=true]: An Activity is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is not Protected. [android:exported=true]: An Activity is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Activity (androidx.activity.ComponentActivity) is not Protected. [android:exported=true]: An Activity is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device.
- Broadcast Receiver (androidx.profileinstaller.ProfileInstallReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed applic
- IP Address disclosure: IP Address disclosure


Files:
com/armsx2/RetroAchievementsHostOverrideReceiver.java, line(s) 105
com/armsx2/config/Dev9HostMapping.java, line(s) 83
com/armsx2/config/Settings.java, line(s) 1574,1575,1576,1577,1578,2491,
- App creates temp file. Sensitive information should never be written into a temp file.: App creates temp file. Sensitive information should never be written into a temp file.


Files:
coil/decode/SourceImageSource.java, line(s) 132
com/github/luben/zstd/util/Native.java, line(s) 122
com/winlator/cmod/featur
- App can read/write to External Storage. Any App can read data written to External Storage.: App can read/write to External Storage. Any App can read data written to External Storage.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#external-storage

Files:
com/armsx2/runtim
- MD5 is a weak hash known to have hash collisions.: MD5 is a weak hash known to have hash collisions.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04g-Testing-Cryptography.md#identifying-insecure-andor-deprecated-cryptographic-algorithms-mstg-crypto-4

Files
- Files may contain hardcoded sensitive information like usernames, passwords, keys etc.: Files may contain hardcoded sensitive information like usernames, passwords, keys etc.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#checking-memory-for-sensitive-data-mstg-storag
- LocalServerSocket has no built-in authentication. Any app on the device can connect to this abstract-namespace UNIX domain socket. Require an authentication handshake before honoring commands received on it.: LocalServerSocket has no built-in authentication. Any app on the device can connect to this abstract-namespace UNIX domain socket. Require an authentication handshake before honoring commands received on it.
https://deve
- This app may contain hardcoded secrets: The following secrets were identified from the app. Ensure that these are not secrets or private information.
"device_profile_feature_session_menu" : "ขนาดปุ่มเมนูในเกม"
"device_profile_feature_session_menu" : "ゲーム内メニューボ

## Scorecard — info (3)
- The App logs information. Sensitive information should never be logged.: The App logs information. Sensitive information should never be logged.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x05d-Testing-Data-Storage.md#logs

Files:
com/armsx2/CustomDriver.java, line(s) 969,728,80
- This App copies data to clipboard. Sensitive data should not be copied to clipboard as other applications can access it.: This App copies data to clipboard. Sensitive data should not be copied to clipboard as other applications can access it.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04b-Mobile-App-Security-Testing.md#clipb
- This app listens to Clipboard changes. Some malware also listen to Clipboard changes.: This app listens to Clipboard changes. Some malware also listen to Clipboard changes.
https://github.com/MobSF/owasp-mstg/blob/master/Document/0x04b-Mobile-App-Security-Testing.md#clipboard

Files:
com/winlator/cmod/runt

## Scorecard — secure (1)
- This application has no privacy trackers: This application does not include any user or device trackers. Unable to find trackers during static analysis.

## Scorecard — hotspot (1)
- Found 9 critical permission(s): Ensure that these permissions are required by the application.

android.permission.BLUETOOTH_CONNECT (dangerous): necessary for connecting to paired Bluetooth devices. - Required to be able to connect to paired Bluetooth

## Dangerous permissions
- android.permission.BLUETOOTH_CONNECT: Required to be able to connect to paired Bluetooth devices.
- android.permission.BLUETOOTH_SCAN: Required to be able to discover and pair nearby Bluetooth devices.
- android.permission.WRITE_EXTERNAL_STORAGE: Allows an application to write to external storage.
- android.permission.READ_EXTERNAL_STORAGE: Allows an application to read from external storage.
- android.permission.RECORD_AUDIO: Allows application to access the audio record path.
- android.permission.MANAGE_EXTERNAL_STORAGE: Allows an application a broad access to external storage in scoped storage. Intended to be used by few apps that need to manage files on behalf of the users.
- android.permission.REQUEST_INSTALL_PACKAGES: Malicious applications can use this to try and trick users into installing additional malicious packages.
- android.permission.POST_NOTIFICATIONS: Allows an app to post notifications
- android.permission.SYSTEM_ALERT_WINDOW: Allows an application to show system-alert windows. Malicious applications can take over the entire screen of the phone.

## Manifest analysis (high/warning)
- [warning] App can be installed on a vulnerable Android version 8.0, minSdk=26]
- [high] Debug Enabled For App [android:debuggable=true]
- [high] Activity (com.winlator.cmod.app.shell.UnifiedActivity) is vulnerable to StrandHogg 2.0
- [high] Activity (com.winlator.cmod.runtime.display.XServerDisplayActivity) is vulnerable to StrandHogg 2.0
- [warning] Activity (com.winlator.cmod.runtime.display.XServerDisplayActivity) is not Protected. [android:exported=true]
- [warning] Broadcast Receiver (com.winlator.cmod.feature.shortcuts.ShortcutBroadcastReceiver) is not Protected. [android:exported=true]
- [warning] Content Provider (com.winlator.cmod.app.provider.WinlatorFilesProvider) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.MANAG
- [warning] Service (androidx.work.impl.background.systemjob.SystemJobService) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.BIND_JOB_S
- [warning] Broadcast Receiver (androidx.work.impl.diagnostics.DiagnosticsReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP 
- [high] Activity (org.dolphinemu.dolphinemu.wn.DolphinEmulationActivity) is vulnerable to StrandHogg 2.0
- [warning] Activity (org.dolphinemu.dolphinemu.wn.DolphinEmulationActivity) is not Protected. [android:exported=true]
- [high] Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is vulnerable to StrandHogg 2.0
- [warning] Activity (com.google.android.gms.games.internal.v2.appshortcuts.PlayGamesAppShortcutsActivity) is not Protected. [android:exported=true]
- [high] Activity (androidx.activity.ComponentActivity) is vulnerable to StrandHogg 2.0
- [warning] Activity (androidx.activity.ComponentActivity) is not Protected. [android:exported=true]
- [warning] Broadcast Receiver (androidx.profileinstaller.ProfileInstallReceiver) is Protected by a permission, but the protection level of the permission should be checked. Permission: android.permission.DUMP [a

## Trackers
0

## APKiD (MobSF)
{"ce876b79be4f104e263fd06a7c96fded.apk": {"packer": ["DexGuard"]}, "classes.dex": {"anti_vm": ["Build.FINGERPRINT check"], "compiler": ["r8"]}, "classes10.dex": {"compiler": ["r8"]}, "classes11.dex": {"compiler": ["r8"]}, "classes12.dex": {"compiler": ["r8"]}, "classes13.dex": {"compiler": ["r8"]}, "classes14.dex": {"compiler": ["r8"]}, "classes15.dex": {"compiler": ["unknown (please file detection issue!)"]}, "classes16.dex": {"compiler": ["r8"]}, "classes17.dex": {"compiler": ["r8"]}, "classes18.dex": {"anti_vm": ["Build.MANUFACTURER check"], "compiler": ["r8"]}, "classes19.dex": {"compiler": ["r8"]}, "classes2.dex": {"compiler": ["r8"]}, "classes20.dex": {"compiler": ["r8"]}, "classes21.dex": {"compiler": ["r8"]}, "classes22.dex": {"compiler": ["r8"]}, "classes23.dex": {"anti_vm": ["Build.MANUFACTURER check"], "compiler": ["r8"]}, "classes24.dex": {"compiler": ["r8"]}, "classes25.dex": {"compiler": ["r8"]}, "classes26.dex": {"anti_vm": ["Build.MANUFACTURER check"], "compiler": ["r8"]}, "classes27.dex": {"compiler": ["r8"]}, "classes28.dex": {"compiler": ["r8"]}, "classes29.dex": {"anti_vm": ["Build.MANUFACTURER check", "Build.BOARD check"], "compiler": ["r8"]}, "classes3.dex": {"compiler": ["r8"]}, "classes30.dex": {"compiler": ["r8"]}, "classes31.dex": {"anti_vm": ["Build.FINGERPRINT check", "Build.MANUFACTURER check"], "compiler": ["r8 without marker (suspicious)"]}, "classes32.dex": {"anti_vm": ["Build.FINGERPRINT check", "Build.MANUFACTURER check"], "compiler": ["r8 without marker (suspicious)"]}, "classes33.dex": {"anti_vm": ["Build.FINGERPRINT check"], "compiler": ["r8 without marker (suspicious)"]}, "classes4.dex": {"compiler": ["r8"]}, "classes5.dex": {"compiler": ["r8"]}, "classes6.dex": {"compiler": ["r8"]}, "classes7.dex": {"compiler": ["r8"]}, "classes8.dex": {"compiler": ["r8"]}, "classes9.dex": {"compiler": ["r8"]}, "lib/arm64-v8a/libproot-loader.so": {"anti_hook": ["syscalls"]}, "assets/linuxfs/usr/local/lib/libwnaudit.so": {"anti_hook": ["syscalls"]}, "assets/linuxfs/usr/local/lib/libwnfastpath.so": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/libwinnative-steamwebhelper-preload.so": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/winnative-driverquery-noop": {"anti_hook": ["syscalls"]}, "assets/xvfb-arm64/winnative-steamwebhelper-wrapper": {"anti_hook": ["syscalls"]}}

## Domains contacted by code (malware-domain check)
- docs.vulkan.org: bad=no
- media.retroachievements.org: bad=no
- api.gog.com: bad=no
- www.epicgames.com: bad=no
- datastorage-public-service-liveegs.live.use1a.on.epicgames.com: bad=no
- auth.gog.com: bad=no
- youtube.com: bad=no
- launcher-public-service-prod06.ol.epicgames.com: bad=no
- git.eden-emu.dev: bad=no
- winnative.dev: bad=no
- www.reddit.com: bad=no
- dns.google: bad=no
- cloudstorage.gog.com: bad=no
- catalog-public-service-prod06.ol.epicgames.com: bad=no
- client-update.fastly.steamstatic.com: bad=no
- ecommerceintegration-public-service-ecomprod02.ol.epicgames.com: bad=no
- registry.khronos.org: bad=no
- api.github.com: bad=no
- github.com: bad=no
- steamcdn-a.akamaihd.net: bad=no
- www.freedesktop.org: bad=no
- account-public-service-prod03.ol.epicgames.com: bad=no
- www.gog.com: bad=no
- itch.io: bad=no
- buildbot.libretro.com: bad=no
- shared.steamstatic.com: bad=no
- account-public-service-prod.ol.epicgames.com: bad=no
- anglebug.com: bad=no
- huggingface.co: bad=no
- store.steampowered.com: bad=no
- retroachievements.org: bad=no
- pcgamingwiki.com: bad=no
- remote-config.gog.com: bad=no
- paypal.me: bad=no
- raw.githubusercontent.com: bad=no
- schemas.microsoft.com: bad=no
- dl.winehq.org: bad=no
- www.steamgriddb.com: bad=no
- docs.rs: bad=no
- steamcommunity.com: bad=no
- embed.gog.com: bad=no
- library-service.live.use1a.on.epicgames.com: bad=no
- thumbnails.libretro.com: bad=no
- cdn.cloudflare.steamstatic.com: bad=no
- android.googlesource.com: bad=no
- epicgames.com: bad=no
- gamesdb.gog.com: bad=no
- shared.akamai.steamstatic.com: bad=no
- cloudflare.epicgamescdn.com: bad=no
- gog-cdn-fastly.gog.com: bad=no
- content-system.gog.com: bad=no
- images.gog.com: bad=no
- yaml.org: bad=no
- godbolt.org: bad=no
- discord.gg: bad=no
- avatars.akamai.steamstatic.com: bad=no
