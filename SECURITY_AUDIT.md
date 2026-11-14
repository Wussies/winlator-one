# NEXORA — SECURITY_AUDIT.md (Этап 0)

Дата: 13.11.2026 · Статус: **аудит исходников и бинарных файлов завершён; на устройстве ничего не запускалось.**
Сырые отчёты сканеров: ветка [`audit/results`](../../tree/audit/results) этого репозитория. Скрипты и workflow аудита: ветка `audit/nexora-stage0` (`audit/`, `.github/workflows/security-audit.yml`, `semgrep-audit.yml`).

## 1. Что проверялось

| Проект | Коммит | Лицензия |
|---|---|---|
| utkarshdalal/GameNative | `f627ee074cd3712097db5641be22358394f0d854` (12.11.2026) | GPL-3.0 + проприетарные компоненты |
| WinNative-Emu/WinNative | `72d145bccff348f71b1c8baf90a180ccaa474464` (25.10.2026) | GPL-3.0 (WFG — MIT) |
| brunodev85/winlator-app | `2c33741d50c5daab0521a098be5c969f63b9e887` (02.11.2026) | LGPL-2.1 |
| brunodev85/winlator | `30aafbdb9eea47b92669201621e03cd2cf04540d` (02.11.2026) | LGPL-2.1 |

**Принцип изоляции:** код проектов только читался. Их Gradle-скрипты, shell-скрипты, бинарники и GitHub Actions **не выполнялись** — ни локально, ни на раннере. Сканирование шло на одноразовом раннере GitHub без секретов.

## 2. Инструменты — что реально выполнено

| Инструмент | Статус | Ограничения (честно) |
|---|---|---|
| **ClamAV 1.5.4** (базы 12.11.2026, 3,6 млн сигнатур) | ✅ выполнен по исходникам **и распакованным** `.tzst/.txz/.zip` архивам (GameNative: 18 471 файл / 2,7 ГБ; WinNative: 4 093 / 2,25 ГБ; winlator-app: 4 533 / 1,3 ГБ) | Сигнатурный сканер: «0 заражений» ≠ доказательство отсутствия вредоносного кода |
| **Gitleaks** (latest, docker) | ✅ рабочее дерево | История git не сканировалась |
| **Trivy** (latest, docker) — vuln/secret/misconfig/license | ✅ | Нашёл только Cargo.lock; у Gradle-проектов нет lockfile → **Maven-зависимости Trivy не покрыл** |
| **OSV-Scanner** (latest, docker) | ✅ | То же: покрыты только Cargo.lock |
| **OSV.dev API** — свой скрипт по объявленным Maven-координатам | ✅ GameNative 69, WinNative 51, winlator-app 8 зависимостей | **Только прямые зависимости.** Транзитивные не разрешались, т.к. для этого пришлось бы выполнить их Gradle-скрипты. NDK prefab-пакеты (OpenSSL/curl) в базе OSV не находятся — проверены вручную |
| **Semgrep 1.185** (p/java, p/kotlin, p/c, p/secrets, p/github-actions, p/insecure-transport, p/default) | ✅ со 2-й попытки | Первый запуск молча упал (код 7) — **не засчитан**. Во 2-м часть файлов не распарсилась (новый синтаксис Kotlin, макросы C) → покрытие частичное |
| **CodeQL** (java-kotlin, c-cpp, `build-mode: none`) | ✅ выполнен | Без сборки: **Kotlin-код не анализируется**, C/C++ — частично. Полный CodeQL требует сборки → будет в CI самой NEXORA |
| Собственные статические проверки (`audit/static_checks.py`) | ✅ | Regex-поиск: exec, dlopen, LD_PRELOAD, WebView, TLS-обходы, телеметрия, подмена package name, эмуляторы Steam API; разрешения манифеста; ревизия CI; инвентаризация бинарников с SHA-256 |
| Ручной анализ кода | ✅ авторизация, сеть, загрузка компонентов, обновления, хранение токенов | Выборочный (по рискам), не построчный аудит ~1 000 000 строк |
| Проверка контрольных сумм бинарников по данным авторов | ⚠️ **невозможна**: ни один из проектов не публикует SHA-256 для своих `.so/.tzst/.dll` | SHA-256 всех файлов зафиксированы в `binaries.json` для будущей сверки |

## 3. Результаты сканеров (сводка)

| | GameNative | WinNative | winlator-app |
|---|---|---|---|
| ClamAV | 0 заражённых | 0 | 0 |
| Gitleaks | 4 (публичные client ID GOG/EA, ложное срабатывание в virglrenderer, тестовые данные) | 36 (35 — хэши/ID в каталоге ретро-ядер, 1 тестовый JWT-заглушка) | 1 (ложное) |
| Known CVE (Rust, Cargo.lock) | 13 уязв. в 7 пакетах: `quinn-proto` (CVSS 7.5), `ruzstd` (7.5), `rustls`, `rsa`, `tokio`… | 14 уязв. в 7 пакетах: `quinn-proto` (7.5, HIGH), `ruzstd` (7.5), `rustls`… | — |
| Known CVE (Maven, прямые) | `commons-lang3 3.17.0`, `org.json 20231013` | 0 найдено; **вручную:** OpenSSL **1.1.1q** (ветка EOL с 09.2023), curl **7.85.0** | `commons-compress 1.20` (5 advisories) |
| Semgrep ERROR | 6 (2 shell-injection в CI, секреты-константы, ProcessBuilder) | 10 (1 shell-injection в CI, ProcessBuilder ×2, `shell=True` в справочных скриптах, tar traversal в build-скрипте) | 1 (ProcessBuilder) |
| CodeQL | Java: zipslip ×3; C/C++: 29 предупреждений (TOCTOU ×2) | Java: unsafe content URI ×2, zipslip, path-injection; C/C++: TOCTOU ×7, overflowing snprintf | Java: path-injection ×10, zipslip ×3 |

Ни один сканер не нашёл известного вредоносного ПО, скрытых загрузчиков DEX, обходов TLS (trust-all) или обфусцированного кода в исходниках.

## 4. Найденные проблемы и уровень риска

### GameNative

| ID | Риск | Проблема |
|---|---|---|
| GN-1 | 🔴 **Критический** | **Закрытые бинарники в ключевом пути выполнения** (по собственному `THIRD_PARTY_NOTICES`): `libredirect.so` — через `LD_PRELOAD` внедряется во **все** процессы Wine/Proton; `libsteambootstrap.so` — получает **refresh-токен Steam** пользователя; `libgamenative_drm.so`. Исходники намеренно не публикуются → проверить невозможно. Авторы сами пишут, что без `libredirect.so` на Android 15+ большинство игр не запустится |
| GN-2 | 🟠 Высокий | Телеметрия PostHog: `PersonProfiles.ALWAYS`, профиль устройства и GPU; часть событий отправляется **вне** проверки согласия (`app_foregrounded/backgrounded`). Активно, если при сборке задан ключ |
| GN-3 | 🟠 Высокий | Удалённая доставка: «AI support» присылает с `api.gamenative.app` компоненты и **патчи файлов игр**; хэш приходит с того же сервера (целостность, но не подлинность) |
| GN-4 | 🟠 Высокий | 168 загружаемых компонентов (драйверы, Proton, Box64, DXVK, VKD3D) в `manifest.json` — **без контрольных сумм**, только TLS; самообновление APK с собственного сервера |
| GN-5 | 🟠 Высокий (политика ТЗ) | Обход DRM: подмена `steam_api.dll` эмулятором **gbe_fork (Goldberg)**, запуск **Steamless** (снятие SteamStub DRM) |
| GN-6 | 🟡 Средний | Форма ввода **пароля Steam** (кроме QR) — противоречит ТЗ |
| GN-7 | 🟡 Средний | Проприетарные драйверы Qualcomm (`SD8Elite_800.35.zip`, `800.51`, `Adreno_819.2_adpkg.zip`…) в assets — права на распространение не подтверждены |
| GN-8 | 🟡 Средний | JavaSteam — изменяемый **SNAPSHOT** из личного форка; `spongycastle 1.58` (2017) |
| GN-9 | 🟡 Средний | Разрешения: `READ_PHONE_STATE`, `READ_LOGS`, `RECORD_AUDIO`, `MANAGE_EXTERNAL_STORAGE`, `REQUEST_INSTALL_PACKAGES`; биллинг RevenueCat, Play Integrity, аккаунты `api.gamenative.app` |
| GN-10 | 🟢 Низкий | CI: shell-injection в `adhoc-signed-build.yml`, 27 неприбитых к SHA actions |
| ✅ | — | Токены Steam шифруются AES-ключом Android Keystore; есть вход по QR |

### WinNative

| ID | Риск | Проблема |
|---|---|---|
| WN-1 | 🟠 Высокий | **Подмена чужих package name**: сборки `com.tencent.ig` (PUBG), `com.antutu.ABenchMark`, `com.ludashi.benchmark` — чтобы OEM-прошивка включала режимы максимальных частот. Это выдача себя за другие приложения и принудительный разгон — запрещено ТЗ |
| WN-2 | 🟠 Высокий (политика ТЗ) | Обход DRM: **ColdClient (gbe_fork)** и **Steamless** |
| WN-3 | 🟠 Высокий | В APK зашиты **проприетарные бинарники Valve** (`valve-steam-x86_64.tzst`, `steam-androidarm64.tzst`, `original_steam_api64.dll`) — права на распространение не подтверждены |
| WN-4 | 🟠 Высокий | Каталоги компонентов/профилей берутся из `main`-ветки **личного** GitHub-аккаунта (`nicholasx417/WinNative-Components`) — изменяемо, без подписи, MD5 |
| WN-5 | 🟡 Средний | OpenSSL 1.1.1q (EOL) и curl 7.85.0 в native-коде Steam; Rust: `quinn-proto` (HIGH), `ruzstd`, `rustls` |
| WN-6 | 🟡 Средний | Разрешения `WRITE_SECURE_SETTINGS`, `SYSTEM_ALERT_WINDOW`, `MANAGE_EXTERNAL_STORAGE`, `REQUEST_INSTALL_PACKAGES`; репозитории jitpack + 2 snapshot |
| WN-7 | 🟡 Средний | Форма ввода пароля Steam (кроме QR) — **пересмотрено в Этапе 4**, см. «Решение по WN-7» |
| WN-8 | 🟢 Низкий | CI: shell-injection в `release.yml:340`; 22 неприбитых actions; огромный объём (PS2/Dolphin/ретро), не нужный NEXORA |
| ✅ | — | Телеметрии не найдено; кроме стандартных библиотек (PulseAudio, libffi, wayland — 8 `.so`) **весь native-код собирается из исходников в репозитории**, включая Steam-клиент (`wn-steam-*`, Rust); обновлятор проверяет подпись нового APK; native-код собирается с 16 KB выравниванием |

### Winlator (brunodev85)
🟢 Низкий риск: нет телеметрии и магазинов; `commons-compress 1.20` (5 advisories); предупреждения path-injection/zipslip; предсобранные `.so` и rootfs от автора без опубликованных хэшей.

### Текущий winlator-one (наш)
🟡 В репозитории лежит **публичный** ключ подписи `app/winlator-one-debug.keystore`. Для NEXORA — только приватный ключ в GitHub Secrets.

## 5. Бинарные файлы

| | Проверено | Не проверено (происхождение не подтверждается хэшами автора) |
|---|---|---|
| Все проекты | ClamAV по всем файлам и содержимому архивов; SHA-256 записаны (`binaries.json`) | Ни один проект не публикует контрольные суммы → **все предсобранные бинарники считаются непроверенными по происхождению** |
| GameNative | 63 ELF, 16 PE, 85 zstd, 10 zip на верхнем уровне; внутри архивов 776 PE, 146 ELF, 4 DEX (DEX — внутри Google bundletool, безопасно) | 3 закрытых `.so` (GN-1) — **неверифицируемы в принципе** |
| WinNative | 36 ELF, 20 PE, 36 zstd, 11 zip; внутри архивов 620 PE, 65 ELF | Бинарники Valve, gbe_fork DLL, Steamless.exe, rootfs/контейнеры |

## 6. Решение

| Проект | Решение |
|---|---|
| **GameNative** | ⛔ **Не использовать как основу.** Критический риск GN-1: закрытый код внедряется в каждый процесс игры и получает токен Steam. Без него, по словам самих авторов, проект на Android 15+ не работает. Перенос допускается только отдельных **открытых** Kotlin-модулей (интеграция Amazon Games) после построчной проверки |
| **WinNative** | ✅ **Использовать как основу — условно**, только после удаления/изоляции: WN-1 (подменные сборки), WN-2 (gbe_fork, Steamless), WN-3 (бинарники Valve), WN-4 (удалённые каталоги), WN-7 (форма пароля), ретро/PS2/Dolphin; обновление OpenSSL/curl и Rust-зависимостей |
| **Winlator** | ✅ Справочная база; компонент Vortek (LGPL-2.1) можно переносить |

**Основная разработка не начинается**, пока карантинный список WinNative не удалён в ветке Этапа 1 и не прогнан повторный аудит (те же сканеры + CodeQL со сборкой в CI NEXORA).

### Неустранённые на сегодня риски
1. Транзитивные Maven-зависимости не проверены (будет: Gradle lockfile + OSV-Scanner в CI NEXORA).
2. Kotlin-код не проверен CodeQL (будет: CodeQL со сборкой в CI).
3. Происхождение предсобранных бинарников (rootfs, Wine, Box64, драйверы) не подтверждено — план: пересборка из исходников в CI или фиксация SHA-256 и источника каждого файла в `THIRD_PARTY_BINARIES.md`.
4. Без gbe_fork/Steamless игры с Steamworks DRM запускаются **только через официальный клиент Steam** — работоспособность этого пути на телефоне не проверена.

---

## Дополнение — Этап 1 (13.11.2026)

Во время подготовки основы найдено то, что статические сканеры Этапа 0 пропустили или не могли увидеть.

| ID | Риск | Находка | Что сделано |
|---|---|---|---|
| S1-1 | 🟠 Пробел аудита | `imagefs.tzst` (200 МБ, основная Linux/Wine-среда) и `proton-9.0-arm64ec.txz` хранятся у WinNative в **Git LFS**; на Этапе 0 были отсканированы только файлы-указатели | Скачаны на раннере, SHA-256 совпал с LFS oid, распакованы, ClamAV **0 / 11 370 файлов**, опись содержимого. Хранятся в релизе `nexora-components-1`, сборка проверяет SHA-256 |
| S1-2 | 🔴 Высокий | `extras.tzst` распаковывал в домашний каталог гостевой системы **неизвестный `Ajay_Prefix_Pro_v1.8_Downloader.exe`** (без исходников и описания), а также Steamless, `generate_interfaces_file.exe` (инструмент Goldberg), `GPUInfo.exe`, `TestD3D.exe` | Архив не импортирован |
| S1-3 | 🟠 Высокий | Мастер первого запуска скачивал Wine/Proton/DXVK/VKD3D/Box64/FEX из **релизов личного аккаунта** `nicholasx417` по изменяемому `default.json`, без проверки целостности. Ссылки в коде к тому же устарели (upstream в любой момент меняет набор) | 10 пакетов текущего набора скачаны, ClamAV **0 / 4 498 файлов**, SHA-256 совпали с дайджестами GitHub для исходных файлов. Зеркало — релиз `nexora-components-2`. Приложение скачивает только эти файлы и только при совпадении SHA-256 и размера (`NexoraComponentPins`) |
| S1-4 | 🟠 Высокий (политика ТЗ) | Модуль ретро-консолей содержит **обход DNAS** (защита PS2 Online) | База обхода удалена, функция выключена. Ретро-модуль скрыт, полное удаление — Этап 2 |
| S1-5 | 🟡 Средний | Обновлятор приложения ведёт на релизы WinNative | Выключен и скрыт |
| S1-6 | 🟡 Средний | Встроенные источники драйверов: `WinNative-Emu/Drivers` и личный репозиторий | Не доверяются по умолчанию; импорт локального ZIP работает |
| S1-7 | 🟢 Низкий | Профили управления скачиваются из личного репозитория (это JSON-данные, не исполняемый код) | Оставлено; будет заменено каталогом NEXORA |
| S1-8 | 🟢 Низкий | Установщики компонентов Windows (VC++, DirectX) скачивают файлы Microsoft с проверкой MD5 | Оставлено (официальный источник); MD5 слабый — заменить на SHA-256 |
| S1-9 | 🟢 Низкий | `xz` 5.4.6 (FetchContent) | Прибит к коммиту; обновление до 5.8.x запланировано |

**Неустранённое на конец Этапа 1:** OpenSSL 1.1.1q и curl 7.85 (native-код клиента Steam), уязвимые Rust-крейты (`quinn-proto`, `rustls`, `ruzstd`), исходный код ретро-эмуляторов ещё в репозитории (выключен), CodeQL со сборкой ещё не запускался.

### Повторный аудит ветки `nexora/main` (коммит `e271eb8`)

Workflow `NEXORA security` (запускается при каждом изменении кода и раз в неделю). Отчёт: `audit/results` → `nexora/e271eb8/`.

| Инструмент | Результат |
|---|---|
| **CodeQL со сборкой** (security-extended, Java + **Kotlin** + C/C++) | 298 предупреждений (Java/Kotlin 195, C/C++ 103), Kotlin теперь проанализирован. Чаще всего: path-injection 62, нет certificate pinning 44, log-injection 28, «потенциально слабый алгоритм» 26 (MD5/SHA-1 для проверки манифестов Epic/GOG — формат магазинов), zipslip 13. Значительная часть C/C++ — в стороннем `proot`. Проверено вручную: `cleartext-storage-shared-prefs` в `PrefManager.kt` — ложное срабатывание (используется `EncryptedSharedPreferences` с ключом Android Keystore). **Полный разбор предупреждений не завершён** — задача Этапа 2 |
| Gitleaks | 36 — те же, что на Этапе 0 (публичные client ID GOG/Epic, хэши каталога ретро-ядер, тестовая JWT-заглушка) |
| OSV-Scanner / Trivy | 14 известных уязвимостей в Rust-крейтах клиента Steam (3 High: `quinn-proto`, `ruzstd`) — не исправлено |
| Semgrep | 62 (5 ERROR: 2 константы client ID, тестовая JWT, 2 ProcessBuilder) |
| ClamAV | imagefs/Proton 9: 0 / 11 370 файлов; 10 компонентов: 0 / 4 498 файлов |

**Решение по Этапу 1:** критические проблемы из карантинного списка устранены или изолированы. Основу можно развивать дальше. Обязательные задачи до первого публичного релиза: разбор предупреждений CodeQL, обновление Rust-крейтов и OpenSSL/curl, полное удаление ретро-модулей.

---

## Аудит APK `nexora-0.1.0-stage1-build.5` (14.11.2026)

Причина: Google Play Защита и антивирус OnePlus пометили APK как вредоносный. Workflow `APK security scan` (ветка `audit/nexora-stage0`), отчёт: `audit/results` → `apk-scan/`. Ничего не запускалось.

| Инструмент | Результат |
|---|---|
| MobSF (static) | Оценка 33/100; трекеров 0; известных вредоносных доменов 0 из 154. High: `android:debuggable=true`; StrandHogg 2.0 (5 Activity); ECB/CBC в `LinuxSteamLogin` (это формат хранения токена самим клиентом Steam) |
| ClamAV 1.5.4 + `--detect-pua` | 14 271 файл / 3,35 ГиБ, **2 срабатывания `PUA.Win.Packer.Embedpe-3`** — `kernel32.dll` из Proton 9 (встроенная DLL Wine, эвристика «PE внутри PE», не вирус) |
| APKiD 3.2.0 | «DexGuard» — ложное срабатывание (правило по шаблону имён ассетов); упаковщиков и обфускаторов нет; проверки `Build.*` — в коде профилей устройств и библиотек Google |
| aapt2 / apksigner | Подпись v2, ключ CI «NEXORA debug»; 25 разрешений |

### Новые находки

| ID | Риск | Находка | Решение |
|---|---|---|---|
| A-1 | 🔴 Высокий | `XServerDisplayActivity` с `exported=true` принимает `boot_exe`/`shortcut_path` от **любого** приложения и выполняет отладочные `DEBUG_INJECT_TAP/KEY` | Этап 4: `exported=false`, удаление отладочных действий |
| A-2 | 🟠 Высокий | Сборка `debuggable=true` | Этап 4: release-сборка |
| A-3 | 🟠 Высокий | Разрешения `WRITE_SECURE_SETTINGS` (не используется), `REQUEST_INSTALL_PACKAGES` (только отключённый обновлятор), `SYSTEM_ALERT_WINDOW` (пузыри чата) | Этап 4: удалить |
| A-4 | 🟡 Средний | `MANAGE_EXTERNAL_STORAGE` — полный доступ к файлам | Этап 8: SAF и папка приложения |
| A-5 | 🟡 Средний | Экспортированы `ShortcutBroadcastReceiver`, `DolphinEmulationActivity`, `PlayGamesAppShortcutsActivity`; сокет `winlator_vibration` без аутентификации | Этап 4 |
| A-6 | 🟡 Средний | Путь Linux-контейнера Steam качает `linuxfs`/`proton-arm64` из релизов WinNative-Emu и драйвер из личного репозитория (SHA-256 приходит с того же сервера) | Этап 6: собрать `linuxfs` в CI из пакетов Arch Linux ARM, закрепить SHA-256 |
| A-7 | 🟡 Средний | `wn-libsteamclient`: диагностическая функция «внедрить тестовый билет владения» | Этап 6: удалить; путь «Bionic Steam» не используется |
| A-8 | 🟢 Инфо | Сотни Windows-программ внутри APK вызывают эвристики антивирусов | Этап 5: Wine/Proton/контейнеры — загрузка при первом запуске из релизов NEXORA с SHA-256 |
| A-9 | 🟠 Высокий (лицензии/происхождение) | Найдено при инвентаризации ассетов (Этап 4, не выявлено в Этапе 0/1 — пропуск аудита). В `assets/wincomponents/` ~250 **оригинальных DLL Microsoft** (большинство подписаны Microsoft): DirectX d3dx9/10/11, d3dcompiler, XAudio/XACT, DirectMusic, DirectPlay, DirectShow, DirectSound, Windows Media (wmasf/wmvcore), VC++ 2010. Системные DLL Windows не являются распространяемыми; d3dx/xaudio/vcrun разрешено распространять только в составе официальных установщиков Microsoft. `ddrawrapper/nglide.tzst` — закрытый freeware nGlide 2.10 (условия распространения не подтверждены). `ddrawrapper/dd7to9.tzst`: файл `dxwrapper.dll` по сведениям о версии — это Microsoft «Direct3D HLSL Compiler», переименованный (происхождение неясно). `assets/winnative/*.exe`, `wnsteam/bionic/*.exe` — готовые бинарники (исходники частично есть в репозитории, сборка не воспроизведена) | Этап 5: удалить из APK; компоненты Microsoft — только по выбору пользователя через официальные установщики Microsoft, запускаемые в Wine; по умолчанию встроенные реализации Wine; nGlide и dd7to9 не поставлять; exe собирать из исходников в CI |

**Вывод:** признаков вредоносного кода не найдено. Срабатывания объясняются debug-сборкой, набором разрешений, Windows-файлами Wine и ретро-модулями. A-1 — реальная уязвимость, исправляется первой.


## Решение по WN-7 (Этап 4)

QR-вход Steam требует второго экрана: на одном телефоне нельзя показать QR-код и
одновременно отсканировать его приложением Steam. Steam не предоставляет игровым
клиентам OAuth-авторизации через браузер, а OpenID не даёт доступа к библиотеке и
загрузке. Поэтому для работы на одном устройстве включён официальный протокол
входа Steam по логину и паролю (тот же, что у настольного клиента), с мерами:

- пароль передаётся только в нативный клиент `wn-steam-client`, шифруется
  RSA-ключом аккаунта, полученным от Steam (`GetPasswordRSAPublicKey`), и
  отправляется только на CM-серверы Valve; собственных серверов у NEXORA нет;
- пароль не сохраняется и не пишется в журналы: у `CredentialsAuthConfig`
  удалён автоматический `Debug` (замена с `<redacted>`), пароль и guard data
  затираются при уничтожении структуры, в том числе на путях ошибок;
  пароль убирается из состояния UI сразу после передачи; проверено, что в
  Kotlin и Rust нет журналирования пароля/токенов;
- поле пароля использует тип клавиатуры «пароль» (IME не запоминает ввод);
- сохраняется только refresh-токен Steam в EncryptedSharedPreferences
  (Android Keystore);
- Steam Guard: подтверждение в официальном приложении Steam или код;
- QR-вход остаётся доступен; в аккаунте Steam устройство видно как
  «NEXORA (Android)».

Остаточный риск: экран ввода пароля Steam в стороннем приложении может
учитываться эвристиками Play Protect как признак фишинга. Это не скрывается и
не обходится; если обнаружение повторится, вход по паролю можно снова
выключить флагом `NexoraPolicy.STEAM_PASSWORD_LOGIN_ENABLED`.


## A-9 — что сделано (Этап 5a)

Удалено из APK:
- `assets/wincomponents/`: direct3d, xaudio, vcrun2010, directmusic, directplay, directshow, directsound, wmdecoder (~250 DLL Microsoft);
- `assets/ddrawrapper/nglide.tzst` (nGlide 2.10, закрытый freeware) и `dd7to9.tzst` (переименованный Microsoft HLSL-компилятор); пункт Dd7To9 убран из списка, безусловная распаковка nGlide удалена;
- из `container_pattern_common.tzst` (перепакован): шрифты Microsoft/Bitstream `app932.fon`, `app936.fon`, `vga932.fon`, `vga936.fon`, `dgVoodooCpl.exe` (dgVoodoo 2, закрытый freeware), `nglide_config.exe`.

Поведение: по умолчанию все компоненты — «Встроенный (Wine)». «Родной (Windows)» теперь только
выставляет порядок загрузки native,builtin, то есть использует DLL Microsoft, если пользователь сам
установил их в контейнер официальным установщиком Microsoft; иначе Wine берёт свою DLL. Пояснение
добавлено в настройки контейнера.

Проверено: остальные Windows-файлы в шаблонах контейнеров — сборки Wine (сведения о версии Wine);
AkelPad (`notepad.exe`, BSD), cnc-ddraw (MIT), d8vk (zlib), ddraw-4.21/11.8 (Wine, LGPL), zink (Mesa, MIT).
Остаётся (Этап 5b): готовые `assets/winnative/*.exe` и `wnsteam/bionic/*.exe` — собрать из исходников в CI;
cnc-ddraw/d8vk/zink — закрепить к официальным релизам по SHA-256.


## Повторная проверка APK `nexora-0.2.0-stage4-build.10` (release, 44d6a07)

Отчёт: ветка `audit/results`, `apk-scan/NEXORA-0.2.0-stage4-build10-44d6a07/`.

| Показатель | build.5 (debug) | build.10 (release) |
|---|---|---|
| debuggable | да | **нет** |
| MobSF security score | 33 | **41** |
| Трекеры | 0 | 0 |
| Опасные разрешения | WRITE_SECURE_SETTINGS, REQUEST_INSTALL_PACKAGES, SYSTEM_ALERT_WINDOW, INSTALL_SHORTCUT | **удалены** |
| Экспортированная `XServerDisplayActivity` | да | **нет** |
| ClamAV (с PUA) | 2 срабатывания | 4 строки, все — `PUA.Win.Packer.Embedpe-3` на `kernel32.dll` Wine внутри `proton-9.0-arm64ec.txz` (ложное: эвристика «PE внутри PE»). Этот архив не используется кодом и удалён в 9ffeff8 |

Осталось из MobSF «high»: StrandHogg 2.0 (уязвимость ОС, исправлена в Android 10+, на OnePlus 13 не применима;
сообщается из-за targetSdk 28, который нужен для запуска Wine), ECB/CBC в библиотеках (BouncyCastle/Steam-протокол
Valve — режимы задаёт протокол). APKiD «DexGuard» — ложное по имени файла; «anti_hook: syscalls» — прямые
системные вызовы proot/Wine-хелперов, это их нормальная работа, а не защита от анализа.
`RECORD_AUDIO` запрашивается только во время игры, если игра открывает микрофон.


## A-7 — что сделано

Удалены все средства «внедрения» данных Steam: в `wn-libsteamclient` — 7 JNI-функций
`nativeDiagnosticInject*` (билет владения, список лицензий, пробная лицензия, состояние входа,
друзья, данные аккаунта, события профиля) и 5 C-экспортов `wn_cm_bridge_inject_test_*`
(Rust `cm_bridge.rs` и заголовок); внутренний метод `inject_ownership_ticket` теперь только для
тестов (`#[cfg(test)]`). Удалён отладочный приёмник `HybridModeReceiver` (1756 строк, команды
через broadcast, в том числе вызов внедрения билета). Сведения о владении и лицензиях теперь
могут прийти только от серверов Steam. Rust: 180/180 тестов.


## Проверка APK `nexora-0.3.0-stage5-build.12` (9ffeff8)

ClamAV с PUA-сигнатурами: **0 срабатываний** (12 272 файла). MobSF: 41, трекеров 0. Отчёт:
`audit/results` → `apk-scan/NEXORA-0.3.0-stage5-build12-9ffeff8/`. Отсутствие срабатываний не
доказывает безопасность; это лишь результат этих сканеров.


## A-10 — R8 удалял методы, которые вызываются из нативного кода (сбой «Install System Files»)

Найдено по сообщению пользователя. В dex сборки 14 у `OnExtractFileListener` остался только
`onExtractFile`; нативный распаковщик ищет ещё 4 метода по имени → `NoSuchMethodError` в ожидании →
аварийное завершение процесса. Той же проверкой найдено ещё 9 удалённых методов (Vulkan, Wayland).
Исправлено (b355bb9): код приложения не переименовывается R8; нативный код очищает исключение.
Регрессионный контроль: `tools/check-jni-dex.py` в CI (сборка падает при отсутствии метода) и
эмуляторный тест установки системных файлов.

## A-6 — что сделано

Компоненты пути «Linux-клиент Steam» зеркалированы в релиз `nexora-components-3` и закреплены по SHA-256
в `LinuxClientInstaller`. Проверка (`audit/results/linux-client`): SHA-256 совпали с опубликованными
upstream; ClamAV — одно срабатывание `PUA.Win.Packer.Embedpe-3` на `kernel32.dll` Wine внутри Proton
(ложное, как и ранее). linuxfs: 165 пакетов в базе pacman, все собраны официальной системой сборки
Arch Linux ARM; **33 219 файлов не принадлежат ни одному записанному пакету** (заголовки GTK/GStreamer/SDL и
др., добавления WinNative) — происхождение этой части не подтверждено. Полное решение — сборка linuxfs в CI
из пакетов Arch Linux ARM (остаётся в плане). Сам клиент Steam по-прежнему скачивается только с серверов
Valve на устройстве (манифест `steam_client_publicbeta_linuxarm64`, проверка SHA-256 по манифесту Valve).

Прочие загрузки с upstream: каталоги компонентов и репозитории драйверов отключены политикой
(`REMOTE_COMPONENT_CATALOGS_ENABLED=false`); загрузка готовых профилей управления из
`nicholasx417/WinNative-Components/Profiles` осталась — это JSON-данные по действию пользователя, не код.
