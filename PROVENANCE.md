# PROVENANCE — origin of the NEXORA code base

NEXORA is a curated fork. This file records exactly where the code came from and what was deliberately left out. See `SECURITY_AUDIT.md` (branch `audit/nexora-stage0`, to be merged into this branch) for the reasons.

## Base

| | |
|---|---|
| Upstream | https://github.com/WinNative-Emu/WinNative |
| Commit | `72d145bccff348f71b1c8baf90a180ccaa474464` (2026-10-25) |
| License | GPL-3.0 (see `LICENSE`); WFG frame generator MIT (`app/src/main/cpp/wfg/LICENSE`) |
| Attribution | `CREDITS.md`, `EMULATOR_CREDITS.md` (kept unchanged from upstream) |
| Import method | `git archive` of the commit above (upstream history is not imported; upstream remains the reference) |

### Submodules (pinned)

| Path | Repository | Commit |
|---|---|---|
| `app/src/main/cpp/adrenotools` | https://github.com/Pipetto-crypto/libadrenotools | `8483dfdaa2abf97ee89ad0e5f337e7b508550c6b` |
| `app/src/main/cpp/vkbasalt` | https://github.com/WinNative-Emu/vkBasalt | `68843cad7f8b4db6ff9806b353776f6974f95e67` |

### Large archives NOT stored in git

Upstream keeps these in Git LFS. NEXORA publishes them as release assets in this repository and verifies SHA-256 (identical to the upstream LFS object id) before every build — see `tools/components.lock`.

| File | SHA-256 (= upstream LFS oid) | Size |
|---|---|---|
| `imagefs.tzst` | `0902e324b60a5c234aa29fcf457f6475a38ef8f61ac2be2118daaef4f236499a` | 199 788 876 |
| `proton-9.0-arm64ec.txz` | `e9df3e74c4a4a17660902092e30b7ceaa5a91cb465f05f28035704808512e180` | 64 654 348 |

## Excluded from the import (never committed here)

| Upstream path | Reason |
|---|---|
| `.github/` | Upstream CI publishes to upstream infrastructure and builds the package-spoofing flavors; replaced by NEXORA CI |
| `app/src/main/assets/steampipe/*` | gbe_fork (Goldberg) Steam API emulator — DRM circumvention |
| `app/src/main/assets/wnsteam/steampipe/*` | gbe_fork + Valve `steam_api64.dll` |
| `app/src/main/assets/wnsteam/steam-androidarm64.tzst` | Valve proprietary Steam client binaries — redistribution rights unconfirmed |
| `app/src/main/assets/wnsteam/bionic/valve-steam-x86_64.tzst`, `steam.exe`, `steam32.exe`, `steamservice.dll`, `steamservice.exe` | Valve proprietary Steam client binaries |
| `app/src/main/assets/experimental-drm.tzst` | ColdClient / DRM stub |
| `app/src/main/assets/extras.tzst` | Steamless (SteamStub DRM removal), `generate_interfaces_file.exe` (Goldberg tool), and an **unidentified third-party executable `home/.Ajay_Prefix/Ajay_Prefix_Pro_v1.8_Downloader.exe`** that upstream unpacks into the guest home directory |
| 10 developer Python scripts (`wn-steam-launcher/.../reference-scripts/*.py`, `wn-steamapi-bridge/gen_*.py`, `tools/linuxfs/tests/*.py`, `tools/sdl/build_android_transport.py`) | Not used by the build; ignored by the upstream `.gitignore` (`*.py`). Two of them were Semgrep findings (`shell=True`, tar traversal) |
| `tools/StubDRM64.dll`, `tools/gbe_fork.version`, `tools/update-gbe-fork.sh` | DRM stub and gbe_fork updater |

Further code-level removals are listed in `CHANGELOG-NEXORA.md`.

## Previous project in this repository

Winlator One 0.1.0 (based on brunodev85/winlator-app, LGPL-2.1) is preserved in branch `backup/winlator-one-0.1.0` and tag `backup-winlator-one-0.1.0` (commit `7673223`).
