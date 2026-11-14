# NEXORA — changelog

Changes relative to the imported base WinNative-Emu/WinNative@72d145b (see PROVENANCE.md).

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
- proot loader offsets are read from the link map when the release toolchain strips the loader's symbol table.

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
