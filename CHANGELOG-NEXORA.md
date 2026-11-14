# NEXORA — changelog

Changes relative to the imported base WinNative-Emu/WinNative@72d145b (see PROVENANCE.md).

## 0.3.0-stage5 (in progress, not tested on a device)

### Fixed — crash on "Install System Files" (builds 10–14)
- Cause: the first R8 release builds stripped `OnExtractFileListener` methods the native extractor calls by name; `GetMethodID` failed and the pending `NoSuchMethodError` aborted the process. Same scan of the shipped dex: Vulkan loader helpers and seven Wayland compositor callbacks were also missing (would have broken game launch / Wayland mode).
- Fix: app classes are kept unrenamed by R8; the native extractor clears the exception when an optional callback is missing.
- The installer now: refuses a second concurrent install; checks the archive exists and free space suffices before deleting anything; guards every stage (an `Error` in a worker can no longer kill the app); removes a half-extracted tree after failure or interruption; tells the user why it failed (no space with the amount, damaged APK, unexpected error).
- CI: `tools/check-jni-dex.py` fails the build if the dex lacks any Java member native code looks up (detects all 13 on build 14); emulator job presses "Install System Files" twice and requires exactly one completed installation without crash. Passed on Android 11 and 15 emulators (build 17) and on Android 11, 15 and 16 emulators (build 19, x86_64 + ARM64 translation), including installing all 10 recommended pinned components. **Not yet verified on a OnePlus 13.**

### Steam (Linux client path, SECURITY_AUDIT A-6)
- Linux runtime, ARM64 Proton and compositor driver are downloaded from NEXORA's mirror (release `nexora-components-3`) and checked against SHA-256 pinned in the source.

### Removed (licensing, SECURITY_AUDIT A-9)
- Microsoft DLLs no longer shipped: DirectX (d3dx9/10/11, d3dcompiler), XAudio/XACT, DirectMusic, DirectPlay, DirectShow, DirectSound, Windows Media decoders, Visual C++ 2010 runtime.
- nGlide and its configurator, dgVoodoo control panel, the Dd7To9 ddraw wrapper (contained a renamed Microsoft binary), Microsoft/Bitstream bitmap fonts in the container template.
- `proton-9.0-arm64ec.txz` (64 MB) is no longer packaged: no code reads it (the Wine list it would be installed from is empty, as upstream). It was the source of the only ClamAV detections (`PUA.Win.Packer.Embedpe`, Wine's kernel32.dll). Wine/Proton come from the verified component downloads.

### Security
- Removed every way to plant Steam data locally (SECURITY_AUDIT A-7): the `nativeDiagnosticInject*` JNI calls (ownership ticket, licenses, trial license, logon state, friends, account info, persona events), the matching `wn_cm_bridge_inject_test_*` exports, and the `HybridModeReceiver` debug broadcast harness. Ownership and licences can only come from Steam's servers.

### Changed
- Windows components default to Wine's builtin DLLs. "Native (Windows)" uses Microsoft's DLLs only when the user installed them in the container with Microsoft's official redistributable; the container settings explain this.

## 0.2.0-stage4 (in progress, not tested on a device)

### Security (SECURITY_AUDIT.md, APK audit A-1…A-5)
- `XServerDisplayActivity` is no longer exported and has no VIEW intent filters (any app could launch arbitrary programs through `boot_exe` / `.desktop` files).
- Removed the `DEBUG_INJECT_TAP` / `DEBUG_INJECT_KEY` intent handlers.
- `ShortcutBroadcastReceiver` not exported; the "shortcut added" broadcast is limited to this app.
- `winlator_vibration` socket accepts only this app's UID.
- Removed permissions `WRITE_SECURE_SETTINGS`, `REQUEST_INSTALL_PACKAGES`, `SYSTEM_ALERT_WINDOW`, `INSTALL_SHORTCUT` (Steam chat heads hidden).
- CI builds the **release** variant (not debuggable, R8) instead of debug.

### Identity
- Package name `io.github.wussies.nexora`; app name NEXORA in all languages.
- Original vector launcher icon (adaptive + monochrome/themed), Android 12+ splash screen, NEXORA colour tokens and base accent colours.
- WinNative badge replaced; the upstream Support page (WinNative donations/Discord) hidden.

### Removed
- Retro console emulation deleted from the source tree (not just hidden): libretro frontend, PS2/ARMSX2, Dolphin, the "Gen1" 3D engine (love2d/SDL glue), RetroAchievements, cheats, the `libretrodroid.aar` download, Gradle modules `:armsx2` and `:dolphin`, `assets/retro`, the related Settings pages. `EMULATOR_CREDITS.md` kept as the historical credit record.

### Steam sign-in (WN-7 revised)
- Username/password sign-in re-enabled, because QR sign-in needs a second screen. The password goes only to the native client, is RSA-encrypted with Valve's key, sent only to Steam's servers and wiped (also on error paths); it is not stored or logged; the password field uses the password keyboard; a notice explains this in the login screen. Steam Guard via app approval or code. QR remains available. Steam shows the device as "NEXORA (Android)".

### Build
- proot loader linked with `-u pokedata_workaround`: release links use `--gc-sections`, which dropped the unreferenced stub proot jumps to.
- First release-variant (non-debuggable, R8) build.

## 0.1.0-stage1 (unreleased, not tested on a device)

### Removed (security quarantine, SECURITY_AUDIT.md)
- Package-impersonation flavors `ludashi` (com.ludashi.benchmark), `pubg` (com.tencent.ig), `antutu` (com.antutu.ABenchMark) and their resources.
- Binaries never imported: gbe_fork/Goldberg, ColdClient, Steamless, Valve Steam client binaries, DRM stubs, `extras.tzst` (incl. unidentified `Ajay_Prefix_Pro_v1.8_Downloader.exe`).
- Gradle repositories: JitPack and both Sonatype snapshot repositories.
- Git LFS usage.

- Code-level quarantine (`NexoraPolicy`): ColdClient, Goldberg `steam_api` injection, Steamless, the Bionic Steam launcher (needs Valve binaries), Steam password sign-in (QR only), upstream self-updater, pre-trusted driver repositories, remote component catalogs.
- PS2 DNAS bypass database (`assets/dnas`); retro console entry points hidden (full removal in Stage 2).

### Changed
- Setup wizard, Components screen and downloader use the pinned catalog `NexoraComponentPins` (10 packages, SHA-256 + size verified, mirrored in release `nexora-components-2`).
- CMake FetchContent (zstd 1.5.6, xz 5.4.6) pinned to commit SHAs instead of mutable tags.
- Rust Steam client built with `cargo --locked` (Cargo.lock is enforced).
- imagefs / Proton arm64ec archives fetched from a pinned release and verified by SHA-256 (`tools/components.lock`, `tools/fetch-components.sh`).

### Added
- NEXORA CI: APK build, persistent debug signing key (or private key from secrets), pre-release publishing.
- Stage 1 bootstrap workflow: backup tag, LFS component verification, ClamAV, inventory.
