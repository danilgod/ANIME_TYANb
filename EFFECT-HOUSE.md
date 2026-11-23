# Маска «Нефор-мейкап» для TikTok — сборка в Effect House

Проект уже собран в Effect House 5.17 через MCP-сервер редактора
(`Effect House AI` → локальный MCP на 127.0.0.1:9100):

`C:\Users\A8987\Documents\Effect House Projects\nefor-makeup`

Что внутри сцены:
- `Makeup` — Face Mask (Whole face) с текстурой `full_look_v2_1024.png`:
  подводка, ресницы, брови, губы, румяна, веснушки, пирсинг, бледный тон.
- `Cat Eyeliner` — библиотечный пресет (готовые стрелки с растушёвкой и
  ресницами), рисуется поверх.
- `BlackHair` — DyeHair, цвет почти чёрный, opacity 0.92.
- `Face Mask Camera`, `GAN Camera` — служебные.

Осталось в редакторе: `Test performance` → `Submit` (публикация требует
твоего TikTok-аккаунта).

Ниже — исходные материалы для ручной сборки и правок.

Готовый набор текстур под официальный шаблон **Effect House Face Mask 2.1+**
(`face_mask_template_210.psd`, скачивается на странице Face Mask в доках).
Все PNG уже нарисованы в нужной развёртке и проверены на эталонном лице из
шаблона — импортируются без подгонки.

## Что в `assets/effecthouse/`

**Быстрый путь — одна текстура на всё лицо:**

| Файл | Размер | Куда в Effect House |
| --- | --- | --- |
| `full_look_1024.png` | 1024×1024 | Face Mask → **Whole face** — весь макияж сразу: подводка с крылом, ресницы, брови, губы, румяна, веснушки, пирсинг |
| `skin_pale_1024.png` | 1024×1024 | Face Mask → **Whole face** — бледный тон, opacity ~40 % |

**Раздельные слои (если надо крутить части отдельно):**

| Файл | Размер | Куда |
| --- | --- | --- |
| `eye_makeup_900x450.png` | 900×450 | Face Mask → Eyes |
| `lashes_900x450.png` | 900×450 | Face Mask → Eyelashes |
| `lips_520x260.png` | 520×260 | Face Mask → Lips |
| `details_1024.png` | 1024×1024 | Face Mask → Whole face (румяна, веснушки, пирсинг) |

Лимиты TikTok соблюдены: каждая картинка ≤ 1024 px и < 1 МБ, пакет
собирается меньше 8 МБ.

## Шаги (быстрый путь, 4 действия)

1. **New Project → Face.**
2. Перетащить `full_look_1024.png` и `skin_pale_1024.png` в панель
   **Assets**.
3. Hierarchy → `+` → Face Effects → **Face Mask** → в Inspector
   `Face Region = Whole face`, `Texture = skin_pale_1024.png`,
   Opacity `0.4`, Blend `Soft Light`.
4. Ещё один **Face Mask** → `Face Region = Whole face`,
   `Texture = full_look_1024.png`, Opacity `1`.
5. Чёрные волосы: `+` → Face Effects → **Hair Segmentation** + Color
   Adjust (затемнить и обесцветить).
6. `Test performance` → `Submit`.

## Шаги (раздельные слои, если нужен контроль)

1. **Установить Effect House** (Windows 10/11). Логин — по QR-коду через
   приложение TikTok: Профиль → Добавить друзей → сканер.
2. **New Project → Face.** Шаблон не обязателен, но можно взять
   `Makeup Palette` и удалить из него лишние объекты.
3. **Импорт текстур:** панель Assets → `+` → Import → From Computer →
   перетащить все пять PNG из `assets/effecthouse/`.
4. **Глаза.** Hierarchy → `+` → Face Effects → **Face Mask**.
   В Inspector: `Face Region = Eyes`, `Texture = eye_makeup_900x450.png`,
   `Opacity Texture` включён, Blend Mode `Normal`, Opacity `1`.
5. **Ресницы.** Ещё один Face Mask: `Face Region = Eyelashes`,
   текстура `lashes_900x450.png`.
6. **Губы.** Face Mask: `Face Region = Lips`, `lips_520x260.png`.
7. **Кожа.** Face Mask: `Face Region = Whole face`, `skin_pale_1024.png`,
   Opacity ≈ `0.4`, Blend Mode `Soft Light` (если слишком белó — `Normal`).
8. **Детали.** Face Mask: `Face Region = Whole face`,
   `details_1024.png`, Opacity `1`. Порядок в Hierarchy: детали **выше**
   бледного тона.
9. **Чёрные волосы.** `+` → Face Effects → **Hair Segmentation**, затем
   Color Adjust / Recolor на маску волос: затемнить и обесцветить до
   почти чёрного. Это самая тяжёлая часть — если тест производительности
   ругается, убери сегментацию и оставь макияж.
10. **Проверка.** Preview с веб-камерой: крыло должно сидеть на веке,
    губы не заезжать на зубы, пирсинг — под нижней губой. Если что-то
    съехало на твоём лице — двигай `Offset` у Face Mask (по 1–2 px) или
    поправь PNG.
11. **Performance.** Кнопка `Test performance` в тулбаре → `Run test`.
12. **Публикация.** `Submit` → иконка 512×512, имя ≤ 25 символов,
    категория `Beauty`, теги, при желании демо-видео → ревью 1–3 дня.

## Как это нарисовано

- Из шаблона взяты эталонное лицо и артборды (Face 2000×2000, Eye и
  Eyelashes 900×450, Lip 520×260).
- С эталонного лица сняты 478 точек MediaPipe FaceLandmarker
  (`mediapipe` в Python), по ним построены контуры век, бровей и губ.
- Подводка, крыло, ресницы и брови — полигоны по контурам с
  суперсэмплингом ×4; тени и румяна — радиальные градиенты; губы —
  градиент по кольцу «внешний контур минус рот», чтобы зубы остались
  прозрачными.
- Пирсинг — два металлических шарика с бликом и затемнением.

Если нужно поменять форму крыла, толщину ресниц или цвет губ — это
правится в PNG (Photoshop/Krita/Affinity) или перегенерацией скрипта.

## Чего в маске нет

- Волосы красятся только цветом (без смены причёски).
- Одежда не меняется.
- Точные названия пунктов меню могут отличаться в версии 5.x — если
  что-то называется иначе, смотри подсказку в Inspector.
