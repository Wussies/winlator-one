# Winlator One — Этап 0: техническое исследование

Дата: 13.11.2026 · Целевое устройство: OnePlus 13 (Snapdragon 8 Elite, Adreno 830, OxygenOS 16 / Android 16, без root)

> Статус документа: исследование исходного кода и открытых источников. **Ничего из перечисленного ниже ещё не проверено на реальном OnePlus 13** — это задача Этапа 2/5.

---

## 1. Какую основу выбрать

**Решение: `brunodev85/winlator-app` (Winlator 11.2, ветка `main`, коммит `2c33741`, 02.11.2026).**

| Критерий | brunodev85/winlator (+ winlator-app) | LLazari/Winlator-Frost |
|---|---|---|
| Версия базы | 11.2 (активно обновляется, последний коммит — ноябрь 2026) | Основан на Winlator 7.1 (`versionCode 16`), один коммит без истории, май 2025 |
| Исходники приложения | Вынесены в сабмодуль `winlator-app` (полноценный Gradle-проект с `gradlew`) | Только `app/` без Gradle wrapper и `settings.gradle` — «как есть» не собирается |
| Тулчейн | AGP 8.4.2, Gradle 8.14.5, compileSdk 35, NDK 24 | compileSdk 30, NDK 22 (устарели) |
| Графика | Turnip 26.2.0, Vortek 2.1, Gladio 1.1, VirGL, Zink; DXVK 1.10.3/2.4.1, VKD3D 2.14.1, D7VK/D8VK | Старый набор времён 7.1, нет Vortek/Gladio |
| Ввод | `GamepadHandler` (до 4 геймпадов, XInput/DInput, вибрация), профили игроков, MIDI | Нет `GamepadHandler`, `GamepadVibration`, `GamepadSlot` |
| Лицензия | LGPL-2.1 | MIT (код от BrunoSX 2023) |

В Frost есть 14 файлов, которых нет в upstream, но почти все — это старые версии того, что в upstream переименовано/переписано (`box86_64/*` → `box64/*`, `core/MS*` → `win32/MS*`, `ImageFs*` → rootfs). Уникальной ценности для нас практически нет: Frost стоит держать только как справочник (README с советами по пресетам Box64 и переменным окружения).

**Вывод:** берём upstream 11.2 целиком, Frost код не копируем.

## 2. Архитектура upstream (как устроено)

```
MainActivity  ── контейнеры, ярлыки, настройки, файловый менеджер, Input Controls
     │
XServerDisplayActivity  ── игровой экран
     ├── xserver/        собственный X11-сервер на Java (Wine подключается как X-клиент)
     ├── renderer/       вывод кадра через GLES + эффекты (FXAA, CRT, Color)
     ├── xenvironment/   «компоненты» среды:
     │     GuestProgramLauncher (glibc rootfs + Box64 + Wine), PulseAudio/ALSA,
     │     SysV SHM, VirGL / Vortek / Gladio серверы
     ├── winhandler/     UDP 7946/7947 ↔ winhandler.exe внутри Wine:
     │     процессы, курсор, геймпады (XInput/DInput), MIDI
     └── inputcontrols/ + widget/InputControlsView, TouchpadView
```

* **Клавиатура и мышь** попадают в Windows через X-сервер: `XServer.injectKeyPress/Release`, `injectPointerMove(Delta)`, `injectPointerButtonPress/Release`.
* **Геймпад** — через `WinHandler` → `winhandler.exe` → XInput/DirectInput внутри Wine (состояние `GamepadState`: 2 стика, 2 аналоговых триггера, D-pad, кнопки).
* **Профили управления** — JSON-файлы `.icp` (53 готовых профиля под игры в `input_controls/`).
* **Native-часть** (`app/src/main/cpp`): `winlator` (JNI), `vortekrenderer`, `gladiorenderer`, `virglrenderer`, `libadrenotools` (загрузка пользовательских драйверов Adreno без root), `midihandler`.
* **Assets (~143 МБ)**: `rootfs.tzst` (glibc-окружение с Wine), Box64 0.4.4, DXVK/VKD3D, графические драйверы, `wincomponents`.

### Зависимости
Java: `appcompat 1.4.0`, `preference 1.2.1`, `material 1.4.0`, `zstd-jni 1.5.2-3`, `xz 1.7`, `commons-compress 1.20`, `lifecycle-process 2.5.1`.
Предсобранные `.so` в `jniLibs/arm64-v8a`: PulseAudio 13, FluidSynth, GLib, Oboe, libsndfile, Vorbis/Opus/FLAC и др. — это бинарные зависимости upstream; их происхождение — README upstream (сборки автора). Пересборка из исходников — отдельная задача (риск R7).

### Система сборки
Gradle wrapper 8.14.5 → AGP 8.4.2 → CMake 3.22.1 + NDK 24.0.8215888. Только `arm64-v8a`. Только тип сборки `debug` (с R8-минификацией).

## 3. Что уже есть в управлении и чего не хватает

| Режим | Что есть в upstream | Что нужно сделать |
|---|---|---|
| **A. Клавиатура + мышь** | Тачпад-режим мыши (`TouchpadView`, чувствительность), вызов **системной** клавиатуры Android | Собственная экранная QWERTY-клавиатура (F1–F12, Numpad, модификаторы с «залипанием», комбинации), панель кнопок мыши (ЛКМ/ПКМ/СКМ/колесо/drag), DPI/ускорение. Отправка — через существующие `injectKey*` / `injectPointer*` |
| **B. Сенсорное управление** | Редактор `ControlsEditorActivity`: BUTTON, D_PAD, STICK, TRACKPAD, RANGE_BUTTON, RADIAL_MENU; размер, прозрачность, форма, toggle; импорт/экспорт `.icp` | Слои, авто-повтор (turbo), макросы/комбинации на одну кнопку, жанровые шаблоны, редактирование поверх запущенной игры |
| **C. Виртуальный геймпад** | Привязки `GAMEPAD_*`, `GamepadState` с аналоговыми триггерами, XInput/DInput через winhandler, вибрация | Отдельный «геймпадный» макет с аналоговыми триггерами на экране (сейчас LT/RT с экрана только 0/1), мёртвые зоны, кривые, калибровка |
| **D. Геймпад → клавиатура/мышь** | Частично: стик можно привязать к клавишам или `MOUSE_MOVE_*`, внешний контроллер можно перепривязать | Аналоговый стик → мышь со скоростью/ускорением/кривой, короткое/длинное нажатие, toggle-состояния, переключение профилей во время игры |

**Реально ли все четыре режима? — Да.** Все четыре сводятся к двум уже работающим «выходам» upstream (X-события клавиатуры/мыши и `GamepadState` через winhandler). Новых системных механизмов (root, uinput, accessibility) не требуется. Самый трудоёмкий — режим D (логика маппинга и тайминги), самый «видимый» — A (своя клавиатура).

### Как сделать систему управления независимой
Новый Gradle-модуль **`:input-core`** (чистая Java, без Android UI, покрывается JVM-тестами):

```
:input-core
  InputSink           ← интерфейс: key(down/up), mouseMove(dx,dy), mouseButton, wheel, gamepad(state)
  mapping/            ← Binding, Action (tap / hold / long-press / toggle / turbo / macro)
  processors/         ← StickToKeys (WASD с порогами), StickToMouse (скорость, ускорение, кривая),
                        Deadzone (radial/axial), TriggerCurve
  profile/            ← модель профиля, слои, JSON (совместим с .icp + наши расширения), миграции
:app
  XServerInputSink, WinHandlerGamepadSink  ← адаптеры к существующему коду upstream
  ui/ (клавиатура, геймпад, редактор, плавающая панель)
```
Так логика управления развивается и тестируется отдельно от Wine/графики, а изменения в файлах upstream остаются минимальными (легче подтягивать обновления Winlator).

## 4. Adreno 830 — ограничения

* Upstream по умолчанию выбирает **Turnip**, если в строке GL-рендерера найден «Adreno 6xx/7xx/8xx» (`GPUHelper.getAdrenoModelId`, `GraphicsDrivers.getDefaultDriver`). Значит на OnePlus 13 по умолчанию будет Turnip 26.2.0 из upstream Mesa. **Работает ли он на A830 через KGSL — не проверено.**
* Поддержка Adreno 8xx в Turnip долго отсутствовала; в ноябре 2025 сообщалось, что драйвер для 8xx только в разработке, и именно поэтому 8 Elite в Winlator/GameHub работал хуже 8 Gen 3.
* Сейчас для A8xx существуют **экспериментальные сборки сообщества** (ветка whitebelyash `turnip/gen8`, сборки Banners-Turnip «A8xx»). Их авторы прямо пишут, что это «compile-verified only», а при артефактах на A830 советуют `TU_DEBUG=sysmem` и для Winlator — `WRAPPER_BLIT=1`.
* **Vortek** (проброс Vulkan в системный драйвер Qualcomm) — самый вероятный «безопасный» вариант для A830, т.к. использует штатный драйвер устройства.
* **VirGL/Zink** — OpenGL-путь; медленнее, но полезен как «Compatibility».

**Политика Winlator One:** не включать экспериментальные A8xx-драйверы по умолчанию. На Этапе 2 — тест-матрица (Turnip upstream / Vortek / VirGL × DXVK / VKD3D / WineD3D) на реальном устройстве; по её итогам — профили Maximum Performance / Balanced / Compatibility / Stability и автоматический откат на Vortek, если Turnip не инициализировался.

## 5. OxygenOS 16 / Android 16 — проблемы

| # | Риск | Что делаем |
|---|---|---|
| O1 | **Агрессивная выгрузка фоновых приложений** OxygenOS: смахивание из «Недавних» может убивать процесс, есть «Auto-Launch» и «Advanced optimization» | Upstream уже держит `ForegroundService` (mediaPlayback). Добавим экран-подсказку: «Батарея → Не оптимизировать», закрепить в «Недавних» |
| O2 | **targetSdk 28** — Android 16 разрешает установку (порог — API 24), но может показать предупреждение «приложение для старой версии Android». Поднять targetSdk ≥ 29 нельзя без отказа от запуска бинарников из data-директории | Оставляем 28; документируем |
| O3 | **16 KB страницы памяти**: Android 15+ поддерживает устройства с 16 KB страницами, в Android 16 есть режим совместимости. 23 из 24 предсобранных `.so` upstream выровнены на 4 KB | Ядро OnePlus 13 сейчас работает с 4 KB страницами, поэтому это не блокер. CI выводит отчёт выравнивания на каждую сборку |
| O4 | Термотроттлинг и Game Assistant OxygenOS при долгих сессиях | Только легальные средства: FPS-лимит, разрешение рендера, `Window.setFrameRatePreference`/`sustained performance` где доступно. Никакого разгона |
| O5 | Scoped storage | Доступ к файлам игр — через SAF / разрешённые папки (как требует ТЗ) |

## 6. Технические риски

| ID | Риск | Влияние |
|---|---|---|
| **R1** | `applicationId` **должен остаться `com.winlator`**: путь `/data/data/com.winlator/...` зашит в rootfs (glibc/Wine) и в native-код (`winlator.h`, `vortek.h`, `gladio.h`). Следствие: Winlator One **нельзя установить рядом с официальным Winlator** — сначала надо удалить официальный (контейнеры будут удалены) | Высокое. Решение в будущем — пересборка rootfs с новым префиксом |
| R2 | Драйвер Turnip на A830 не проверен | Высокое для производительности |
| R3 | Объём APK ~150+ МБ (rootfs 63 МБ, direct3d 30 МБ) | Среднее |
| R4 | Лицензия LGPL-2.1: изменённый код должен оставаться под LGPL, исходники — доступны получателям APK | Учтено: репозиторий, NOTICE.md |
| R5 | Upstream активно меняется → конфликты при слиянии | Минимум правок в файлах upstream, новая логика — в отдельных модулях; ветка `upstream-main` для синхронизации |
| R6 | 16 KB выравнивание (см. O3) | Низкое сейчас |
| R7 | Предсобранные бинарники upstream (`.so`, `.tzst`) нельзя проверить сборкой из исходников в рамках Этапа 1 | Среднее; используем только официальные артефакты upstream, без сторонних сборок |
| R8 | Локальная сборка в среде разработки недоступна (нет доступа к Google Maven/SDK) → APK проверяется только в GitHub Actions | Низкое |

## 7. План модификации

* **Этап 1 (сейчас):** форк upstream 11.2, ветки `main` (наша) и `upstream-main` (чистый upstream), стабильная подпись, CI-сборка APK, документация. Функциональность Winlator не меняется — только название и версия.
* **Этап 2:** тест-матрица графики на OnePlus 13, авто-откат драйвера, графические профили (5 штук), подсказки по OxygenOS.
* **Этап 3:** модуль `:input-core` + режимы A → C → D → B-расширения, плавающая панель переключения режимов, профили на игру.
* **Этап 4:** игровая библиотека (обложки, описания, настройки на игру) поверх существующих «ярлыков» upstream, мобильный UI 120 Гц.
* **Этап 5:** тесты по списку ТЗ.

## 8. Минимальный рабочий результат

1. **Сейчас:** устанавливаемый APK «Winlator One» = Winlator 11.2 без функциональных изменений, собираемый GitHub Actions, с постоянной подписью (обновления ставятся поверх).
2. **Первый «свой» результат (Этап 3, часть 1):** режим D для одного профиля: левый стик → WASD, правый стик → мышь с ускорением, RT/LT → ЛКМ/ПКМ, A/B/X/Y → Space/Esc/E/R, с JVM-тестами логики в CI.

## Источники
* https://github.com/brunodev85/winlator, https://github.com/brunodev85/winlator-app
* https://github.com/LLazari/Winlator-Frost
* https://www.androidauthority.com/snapdragon-8-elite-8-elite-gen-5-devices-emulation-driver-3617718
* https://github.com/The412Banner/Banners-Turnip/releases
* https://developer.android.com/guide/practices/page-sizes
* https://developer.android.com/about/versions/16/behavior-changes-all
* https://dontkillmyapp.com/oneplus
