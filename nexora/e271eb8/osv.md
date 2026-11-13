Scanning dir /src
Starting filesystem walk for root: /
Scanned /src/app/libs/MidiSynth file and found 0 packages
Scanned /src/app/src/main/cpp/thirdparty/dxbc file and found 0 packages
Scanned /src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock file and found 223 packages
Scanned /src/app/src/main/rust/wn-steam-tools/Cargo.lock file and found 2 packages
Scanned /src/vendor/maven file and found 0 packages
Scanned /src/vendor/maven/org/libsdl/android/SDL3/3.4.16-winnative.2/SDL3-3.4.16-winnative.2.pom file and found 0 packages
Scanned /src/vendor/maven/org/libsdl/android/SDL3/3.4.16/SDL3-3.4.16.pom file and found 0 packages
Scanned /src/vendor/maven/org/libsdl/android/SDL3/3.4.16-winnative.1/SDL3-3.4.16-winnative.1.pom file and found 0 packages
Scanned /src/dolphin/vendored/java file and found 0 packages
End status: 517 dirs visited, 2611 inodes visited, 9 Extract calls, 601.971444ms elapsed, 601.971655ms wall time

Total 7 packages affected by 14 known vulnerabilities (0 Critical, 3 High, 3 Medium, 2 Low, 6 Unknown) from 1 ecosystem.
14 vulnerabilities can be fixed.

| OSV URL | CVSS | Ecosystem | Package | Version | Fixed Version | Source |
| --- | --- | --- | --- | --- | --- | --- |
| https://osv.dev/RUSTSEC-2026-0185<br/>https://osv.dev/GHSA-4w2j-m93h-cj5j | 7.5 | crates.io | quinn-proto | 0.11.14 | 0.11.15 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0338 |  | crates.io | quinn-proto | 0.11.14 | 0.11.18 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0339 |  | crates.io | quinn-proto | 0.11.14 | 0.11.17 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0340 | 7.5 | crates.io | quinn-proto | 0.11.14 | 0.11.18 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0342 |  | crates.io | quinn-proto | 0.11.14 | 0.11.17 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2023-0071 | 5.9 | crates.io | rsa | 0.9.10 | 0.10.0 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0285<br/>https://osv.dev/GHSA-2mjx-qc3c-rqvc | 5.3 | crates.io | rustls | 0.23.40 | 0.23.45 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0346<br/>https://osv.dev/GHSA-c8m5-c952-6cm4 | 4.0 | crates.io | rustls | 0.23.40 | 0.23.46 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0348<br/>https://osv.dev/GHSA-h2v8-394m-p7vv | 3.7 | crates.io | rustls | 0.23.40 | 0.23.46 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0349<br/>https://osv.dev/GHSA-w44r-93j7-qv28 | 3.7 | crates.io | rustls | 0.23.40 | 0.23.46 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0382 |  | crates.io | rustls-webpki | 0.103.13 | 0.103.16 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0344 | 7.5 | crates.io | ruzstd | 0.7.3 | 0.9.1 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0386 |  | crates.io | tokio | 1.52.3 | 1.53.3 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
| https://osv.dev/RUSTSEC-2026-0381 |  | crates.io | webpki-roots | 1.0.7 | 1.0.10 | src/app/src/main/cpp/wn-steam-client/rust/Cargo.lock |
