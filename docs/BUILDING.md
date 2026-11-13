# Сборка Winlator One

## Через GitHub Actions (основной способ)

1. Любой push в `main` (или ветки `dev/**`, `feature/**`) запускает workflow **Build APK**.
2. Вручную: вкладка **Actions → Build APK → Run workflow**.
3. Готовый APK: открыть завершённый запуск → блок **Artifacts** → скачать zip → внутри `WinlatorOne-<версия>-build<N>-<commit>.apk` и `.sha256`.
4. Релиз: каждая успешная сборка `main` автоматически публикуется как pre-release `v<версия>-build.<N>` во вкладке **Releases** — APK можно скачать прямо с телефона. Push тега `v*` создаёт обычный релиз.

Сборка занимает ~10–20 минут (основное время — CMake/NDK).

В отчёте запуска (Summary) есть таблица выравнивания native-библиотек под 16 KB страницы — она информационная.

## Подпись

* По умолчанию APK подписывается **проектным ключом** `app/winlator-one-debug.keystore` (пароль `winlatorone`). Он публичный — это «debug»-ключ, нужен только чтобы каждая новая сборка ставилась **поверх** предыдущей без удаления.
* Чтобы подписывать своим приватным ключом, добавьте в *Settings → Secrets and variables → Actions*:
  * `ONE_KEYSTORE_BASE64` — keystore в base64,
  * `ONE_KEYSTORE_PASSWORD`, `ONE_KEY_ALIAS`, `ONE_KEY_PASSWORD`.

  ⚠️ После смены ключа уже установленное приложение придётся удалить один раз.

## Установка на OnePlus 13

* Winlator One использует тот же package name, что и официальный Winlator (`com.winlator`) — см. `docs/STAGE0_RESEARCH.md`, риск R1. Если стоит официальный Winlator, Android откажется ставить APK поверх (другая подпись). Удалите официальный (контейнеры будут удалены) и установите Winlator One.
* Возможное предупреждение «приложение создано для старой версии Android» — ожидаемо (targetSdk 28 нужен для запуска Wine/Box64).

## Локальная сборка

Требуется: JDK 17, Android SDK (platform 35, build-tools 35.0.0), NDK `24.0.8215888`, CMake `3.22.1`.

```bash
./gradlew assembleDebug
# результат: app/build/outputs/apk/debug/app-debug.apk
```

## Синхронизация с upstream

```bash
git remote add upstream https://github.com/brunodev85/winlator-app.git
git fetch upstream
git checkout upstream-main && git merge --ff-only upstream/main && git push origin upstream-main
git checkout main && git merge upstream-main
```
