# NEXORA — changelog

Changes relative to the imported base WinNative-Emu/WinNative@72d145b (see PROVENANCE.md).

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
