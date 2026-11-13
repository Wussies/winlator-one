## Static checks: `target`

### Pattern hits (count — first 8 locations)
- **exec: Runtime.exec / ProcessBuilder**: 0
- **exec: native system/popen/exec***: 0
- **dynamic code: DexClassLoader / InMemoryDex**: 0
- **dynamic native: System.load / dlopen**: 0
- **webview: addJavascriptInterface**: 0
- **webview: file access enabled**: 0
- **tls: trust-all / hostname bypass**: 0
- **cleartext http:// URL**: 0
- **secrets in logs (password/token logged)**: 0
- **base64 blob (>200 chars)**: 0
- **analytics/telemetry SDK**: 0
- **LD_PRELOAD / library injection**: 0
- **chmod / setExecutable**: 0
- **package spoofing (other apps' ids)**: 0
- **Steam API emulator (gbe_fork/Goldberg/ColdClient)**: 0

### Android permissions requested

- none

### Exported components (0)


### CI workflow review

- no workflows / no findings

### Binary inventory

Top-level binary files: {'ZSTD': 19}
Files found inside extracted archives: {'PE': 136, 'ELF': 6}

| path | type | MB | sha256 |
|---|---|---|---|
| installable_components/dxvk/dxvk-2.6.1.tzst | ZSTD | 4.7 | `29a198dbc4a9e585…` |
| installable_components/box64/box64-0.4.5.tzst | ZSTD | 4.6 | `ba9e8acb06b9d8a3…` |
| installable_components/dxvk/dxvk-2.5.2.tzst | ZSTD | 4.4 | `c311f79528456eb6…` |
| installable_components/box64/box64-0.3.5.tzst | ZSTD | 4.1 | `97f813d3f3b8aaf3…` |
| installable_components/box64/box64-0.3.7.tzst | ZSTD | 4.0 | `2f78d547fac9d5c0…` |
| installable_components/vkd3d/vkd3d-2.14.1.tzst | ZSTD | 4.0 | `3d37bc3784526823…` |
| installable_components/vkd3d/vkd3d-3.0b.tzst | ZSTD | 4.0 | `37bc0549e4c6f7eb…` |
| installable_components/dxvk/dxvk-2.3.1.tzst | ZSTD | 3.9 | `0e1104e1ebf34c0f…` |
| installable_components/dxvk/dxvk-2.2.tzst | ZSTD | 3.8 | `4fb3616bf9d2d89a…` |
| installable_components/vkd3d/vkd3d-2.12.tzst | ZSTD | 3.6 | `9929ee5a3347c927…` |
| installable_components/wined3d/wined3d-10.0.tzst | ZSTD | 3.5 | `6b85af76c76ac11c…` |
| installable_components/dxvk/dxvk-1.7.2.tzst | ZSTD | 3.2 | `a5d72f5b108faf84…` |
| installable_components/wined3d/wined3d-7.8.tzst | ZSTD | 3.0 | `7cef3d0d1c348a2b…` |
| installable_components/turnip/turnip-26.0.3.tzst | ZSTD | 2.4 | `085e05496ccf5056…` |
| installable_components/dxvk/dxvk-1.4.2.tzst | ZSTD | 2.2 | `14988a4be1581a1b…` |
| installable_components/wined3d/wined3d-4.21.tzst | ZSTD | 2.1 | `48f2479432faf7b9…` |
| installable_components/turnip/turnip-25.0.0.tzst | ZSTD | 2.1 | `4a57d0fe980b3685…` |
| installable_components/dxvk/dxvk-0.96.tzst | ZSTD | 1.9 | `d9131ce35b39d775…` |
| installable_components/turnip/turnip-24.1.0.tzst | ZSTD | 1.8 | `96989279ac6e440f…` |

### Declared dependencies: 0 (full list in deps.txt)
