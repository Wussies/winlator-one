# Winlator One — Changelog

All changes relative to upstream Winlator 11.2 (`brunodev85/winlator-app@2c33741`).

## 0.1.0 — Stage 1: project base (unreleased, not yet tested on device)

### Added
- GitHub Actions workflow `.github/workflows/build-apk.yml`: builds the APK on every push, uploads it as an artifact, attaches it to a GitHub Release on `v*` tags, and reports native library 16 KB alignment.
- Fixed project signing key `app/winlator-one-debug.keystore` so CI builds install as updates over each other; optional private key via repository secrets.
- `tools/check_elf_alignment.sh`.
- Documentation: `docs/STAGE0_RESEARCH.md` (Stage 0 research report), `docs/BUILDING.md`, `NOTICE.md`.

### Changed
- App label: `Winlator` → `Winlator One` (en/pt/ru).
- `versionName` → `11.2-one-0.1.0`, `versionCode` → `1000 + CI run number`.
- `lintOptions.abortOnError false` (lint must not block CI builds).

### Unchanged on purpose
- `applicationId` stays `com.winlator` (paths compiled into rootfs and native code).
- `targetSdkVersion` stays 28 (required to execute Wine/Box64 from app storage).
- No runtime, graphics, Wine, Box64 or input behaviour has been changed.
