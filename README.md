# NEXORA

Платформа для запуска Windows-игр на Android (Wine + Box64/FEX, DXVK/VKD3D) с библиотеками Steam, Epic и GOG, ориентированная на **OnePlus 13** (Snapdragon 8 Elite / Adreno 830, Android 16).

> NEXORA использует **Wine** — это не настоящая Windows. NEXORA не содержит эмуляторов Steam и средств снятия DRM.

## Статус: Этап 1 — новая основа

Код основан на [WinNative](https://github.com/WinNative-Emu/WinNative) (`72d145b`, GPL-3.0) и прошёл аудит и чистку — см. [`SECURITY_AUDIT.md`](SECURITY_AUDIT.md), [`PROVENANCE.md`](PROVENANCE.md), [`CHANGELOG-NEXORA.md`](CHANGELOG-NEXORA.md). Название, иконка и интерфейс NEXORA появятся на Этапе 2; сейчас приложение ещё выглядит как WinNative.

| Функция | Статус |
|---|---|
| Сборка APK в GitHub Actions | ✅ Реализовано (APK собирается) |
| Установка на Android 16 / запуск на OnePlus 13 | ⏳ Реализовано, но **не проверено на устройстве** |
| Вход в Steam только по QR-коду | ⏳ Реализовано, не проверено |
| Библиотека и загрузка Steam / Epic / GOG | ⏳ Унаследовано от WinNative, не проверено |
| Запуск игр Steam, которым нужен клиент Steam / Steam DRM | ❌ Не реализовано (официальный клиент Steam ещё не подключён) |
| Компоненты Wine/Proton/DXVK/VKD3D/Box64/FEX | ✅ Только закреплённые версии с проверкой SHA-256 |
| Amazon Games, встроенный браузер, 4 режима управления, дизайн NEXORA | ❌ Этапы 2–6 |

## Скачать

Вкладка **Releases** → последний `nexora-0.1.0-stage1-build.N` (pre-release). APK большой (~540 МБ): в него входит Linux/Wine-среда.

## Ветки

- `nexora/main` — NEXORA (эта ветка).
- `main` — пока старый Winlator One; будет заменён обычным слиянием после проверки.
- `backup/winlator-one-0.1.0` и тег `backup-winlator-one-0.1.0` — резервная копия старого проекта.
- `audit/nexora-stage0`, `audit/results` — скрипты и отчёты аудита.

## Лицензия

GPL-3.0 (см. `LICENSE`). Авторы исходных проектов — `CREDITS.md`, `EMULATOR_CREDITS.md`.
