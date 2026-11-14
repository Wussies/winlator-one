# NEXORA

Платформа для запуска Windows-игр на Android (Wine + Box64/FEX, DXVK/VKD3D) с библиотеками Steam, Epic и GOG, ориентированная на **OnePlus 13** (Snapdragon 8 Elite / Adreno 830, Android 16).

> NEXORA использует **Wine** — это не настоящая Windows. NEXORA не содержит эмуляторов Steam и средств снятия DRM.

## Статус: Этапы 4–6 в работе (ничего не проверено на устройстве)

Код основан на [WinNative](https://github.com/WinNative-Emu/WinNative) (`72d145b`, GPL-3.0) и прошёл аудит и чистку — см. [`SECURITY_AUDIT.md`](SECURITY_AUDIT.md), [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md), [`PROVENANCE.md`](PROVENANCE.md), [`CHANGELOG-NEXORA.md`](CHANGELOG-NEXORA.md).

Статусы: Implemented → Build Verified → Runtime Verified → Device Verified.

| Функция | Статус |
|---|---|
| Release-сборка APK в GitHub Actions (не debuggable, R8), пакет `io.github.wussies.nexora`, иконка и тема NEXORA | **Build Verified** |
| Проверка APK: MobSF, ClamAV (0 срабатываний), APKiD | **Build Verified** (build.12) |
| Установка на Android 16 / запуск на OnePlus 13 | Implemented, не проверено на устройстве |
| Вход в Steam: логин/пароль (только к серверам Valve) + Steam Guard, или QR | Implemented, не проверено |
| Библиотека и загрузка Steam / Epic / GOG | Унаследовано от WinNative, не проверено |
| Запуск игр, которым нужен клиент Steam / Steam DRM | Not Implemented (официальный клиент Steam — Этап 6) |
| Компоненты Wine/Proton/DXVK/VKD3D/Box64/FEX | Build Verified: только закреплённые версии с проверкой SHA-256 |
| DLL Microsoft (DirectX, VC++ и др.) | Не поставляются; можно установить официальным установщиком Microsoft в контейнер |
| Ретро-эмуляторы | Удалены |
| Amazon Games, встроенный браузер, 4 режима управления, настройка под OnePlus 13 | Not Implemented (Этапы 7–10) |

## Скачать

Вкладка **Releases** → последний `nexora-0.3.0-stage5-build.N` (pre-release, ~375 МБ: внутри Linux-среда и шаблоны Wine).

## Ветки

- `nexora/main` — NEXORA (эта ветка).
- `main` — пока старый Winlator One; будет заменён обычным слиянием после проверки.
- `backup/winlator-one-0.1.0` и тег `backup-winlator-one-0.1.0` — резервная копия старого проекта.
- `audit/nexora-stage0`, `audit/results` — скрипты и отчёты аудита.

## Лицензия

GPL-3.0 (см. `LICENSE`). Авторы исходных проектов — `CREDITS.md`, `EMULATOR_CREDITS.md`.
