# THIRD_PARTY_NOTICES — NEXORA

NEXORA is distributed under the **GNU General Public License v3.0** (`LICENSE`). It contains or downloads the components listed below. Each keeps its own license and copyright. The complete corresponding source of NEXORA is this repository; sources of copyleft components are available from the upstream projects linked here (and, for patched components, from this repository).

Full upstream attributions are preserved unchanged in `CREDITS.md` and `EMULATOR_CREDITS.md` (from WinNative). Origin and exclusions of the code base: `PROVENANCE.md`. Security results: `SECURITY_AUDIT.md`.

"Audit" below: **CA** = ClamAV clean, **CQ** = in CodeQL/Semgrep scope, **SHA** = pinned by SHA-256, **SRC** = built from source in this repository's CI, **BIN** = third-party prebuilt binary (provenance not reproducible yet).

## Application code

| Component | Repository | Version / commit | Author | License | Purpose | Audit | Why chosen | NEXORA changes |
|---|---|---|---|---|---|---|---|---|
| WinNative | github.com/WinNative-Emu/WinNative | `72d145b` | WinNative contributors | GPL-3.0 | Application base | CA, CQ, SRC | Most open candidate; open Steam client | Quarantine (`CHANGELOG-NEXORA.md`), `NexoraPolicy`, pinned catalog |
| Winlator | github.com/brunodev85/winlator | via WinNative | BrunoSX (brunodev85) | see upstream (LGPL-2.1 for current versions) | X server, Wine environment, input controls | CA, CQ, SRC | Core of the emulation layer | via WinNative |
| Winlator Bionic | github.com/Pipetto-crypto/winlator | via WinNative | Pipetto-crypto | see upstream | Bionic (Android-native) Wine runtime | CA, CQ, SRC | Package-independent runtime | — |
| Pluvia / GameNative (Steam, Epic, GOG UI and services) | github.com/oxters168/Pluvia, github.com/utkarshdalal/GameNative | via WinNative | Pluvia / GameNative contributors | GPL-3.0 | Store integration code | CA, CQ, SRC | Open Kotlin parts only; GameNative's closed libraries are **not** used | Steam sign-in policy, DRM paths disabled |
| wn-steam-client (Rust) | in this repo (`app/src/main/cpp/wn-steam-client`) | from WinNative `72d145b` | WinNative contributors | GPL-3.0 | Steam CM protocol: sign-in, PICS, depots | CQ, SRC; **14 known CVEs in crates (3 High) — not fixed yet** | Open, no SNAPSHOT dependency | `cargo --locked` |
| libadrenotools (fork) | github.com/Pipetto-crypto/libadrenotools | `8483dfd` (submodule) | bylaws; Pipetto-crypto | BSD-2-Clause | Load custom Adreno Vulkan drivers without root | SRC | Required for driver selection | — |
| vkBasalt (fork) | github.com/WinNative-Emu/vkBasalt | `68843ca` (submodule) | DadSchoorse; WinNative | zlib | Post-processing layer | SRC | — | — |
| PRoot | github.com/proot-me/proot (vendored) | in tree | STMicroelectronics and contributors | GPL-2.0 | Linux runtime container | SRC; CodeQL warnings (upstream code) | Needed for the Linux Steam client container | — |
| patchelf | github.com/NixOS/patchelf (vendored) | in tree | Eelco Dolstra and contributors | GPL-3.0 | ELF relocation of runtime binaries | SRC | — | — |
| Wayland compositor, libwayland-server 1.26, libffi | github.com/The412Banner/Bannerlator | via WinNative | The412Banner; freedesktop.org; libffi authors | MIT | Wayland display path | SRC / BIN (libffi, wayland .so) | — | — |
| DirectAudio | github.com/The412Banner/directaudio | via WinNative | The412Banner | LGPL-2.1-or-later | Wine → AAudio audio driver | SRC | — | — |
| WFG frame generator | in tree (`cpp/wfg`) | via WinNative | qwertypower (DEVAR Entertainment LLC) | MIT | Frame generation | SRC | — | — |
| lsfg-vk / Eden LSFG port | github.com/PancakeTAS/lsfg-vk, git.eden-emu.dev | via WinNative | PancakeTAS; Camille LaVey | GPL-3.0-or-later | Frame generation (shaders read from the user's own Lossless Scaling copy) | SRC | — | — |
| DXVK `dxbc` (vendored) | github.com/doitsujin/dxvk | in tree | Philip Rebohle and contributors | zlib | Shader translation for frame generation | SRC | — | — |
| zstd | github.com/facebook/zstd | v1.5.6 = `794ea1b` | Meta Platforms | BSD-3-Clause / GPL-2.0 | Decompression | SRC, pinned commit | — | Pinned to commit |
| xz / liblzma | github.com/tukaani-project/xz | v5.4.6 = `6e8732c` | Lasse Collin and contributors | 0BSD / public domain | Decompression | SRC, pinned commit | Predates CVE-2024-3094 | Pinned; upgrade planned |
| PulseAudio, libsndfile, libltdl, OpenSSL 1.1.1q, curl 7.85 | upstream projects | prebuilt in `jniLibs` / NDK prefab | respective authors | LGPL-2.1 / LGPL / Apache-2.0 / curl | Audio, TLS for native Steam code | **BIN; OpenSSL 1.1.1 is EOL** | Inherited | Replacement planned (Stage 5/6) |

Java/Kotlin libraries (AndroidX, Compose, Room, Hilt, OkHttp, Coil, zstd-jni, Apache Commons Compress, etc.) are resolved by Gradle from Google Maven and Maven Central. The exact list with versions is in `gradle/libs.versions.toml` and `app/build.gradle`; each library's license is included in its artifact. Rust crates (223 entries) are pinned in `app/src/main/cpp/wn-steam-client/rust/Cargo.lock`.

## Runtime components (not in git; pinned, mirrored in this repository's releases)

| Component | Upstream source | Version / commit | Author | License | Purpose | Audit | NEXORA changes |
|---|---|---|---|---|---|---|---|
| imagefs (Android-native Linux userland, Wine) | WinNative Git LFS | SHA-256 `0902e324…` | WinNative; Termux packages | various (GPL/LGPL/MIT…) | Base runtime | CA (11 370 files), SHA, **BIN** | Mirrored as `nexora-components-1` |
| Proton 9.0 arm64ec | WinNative Git LFS | SHA-256 `e9df3e74…` | Valve, CodeWeavers, Wine project | LGPL-2.1+ / BSD | ARM64EC Wine | CA (ClamAV PUA heuristic `Embedpe` on `kernel32.dll` — Wine false positive), SHA, BIN | Mirrored |
| Proton 11.0-2 (x86-64, arm64ec) | github.com/nicholasx417/WinNative-Components | assets of 2026-09-12 | Valve; packaged by nicholasx417 | LGPL-2.1+ / BSD | Wine for games | CA, SHA (= GitHub asset digest), BIN | Mirrored as `nexora-components-2` |
| Box64 0.4.3 / WOWBox64 | github.com/ptitSeb/box64 | `c08554e` (packaged by nicholasx417) | ptitSeb and contributors | MIT | x86-64 emulation | CA, SHA, BIN → **to be rebuilt from official source (Stage 5)** | Mirrored |
| FEXCore 2607 | github.com/FEX-Emu/FEX | `84e127a` (packaged by nicholasx417) | FEX-Emu contributors | MIT | ARM64EC emulation | CA, SHA, BIN → rebuild planned | Mirrored |
| DXVK 3.0.2 gplasync / 2.4.1 | github.com/doitsujin/dxvk (+ gplasync patch) | 3.0.2 = `6b20f62` | Philip Rebohle; gplasync patch authors | zlib | Direct3D 8–11 → Vulkan | CA, SHA, BIN → official release planned | Mirrored |
| VKD3D-Proton 3.0.1 | github.com/HansKristian-Work/vkd3d-proton | 3.0.1 = `3b10bd7` | Hans-Kristian Arntzen and contributors | LGPL-2.1 | Direct3D 12 → Vulkan | CA, SHA, BIN → official release planned | Mirrored |
| Valve Steam client (arm64 Linux) | Valve update CDN `client-update.fastly.steamstatic.com` | downloaded on the device | Valve Corporation | Steam Subscriber Agreement (**not redistributed by NEXORA**) | Official Steam client for Steamworks/DRM games | SHA-256 per Valve's manifest, checked on device | — |
| Microsoft redistributables (VC++, DirectX) | Microsoft download servers (winetricks-style verbs) | as listed in the verbs | Microsoft | Microsoft redistributable licenses | Game dependencies | MD5 from verbs (weak; SHA-256 planned) | — |

## Excluded components

See `PROVENANCE.md` → "Excluded from the import" and `SECURITY_AUDIT.md`. Notably **not** used: GameNative's closed `libredirect.so`, `libsteambootstrap.so`, `libgamenative_drm.so`; gbe_fork/Goldberg, ColdClient, Steamless; Valve binaries inside the APK; the unidentified `Ajay_Prefix_Pro_v1.8_Downloader.exe`.
