# Альтушка-грязнулька

3D-игра про то, как отмыть и одеть альтушку. Персонаж — VRM-модель
(Sendagaya Shino, CC0-подобная лицензия VRoid), рендер на three.js.

## Запуск

Двойной клик по `Запустить игру.bat`.

Он поднимает локальный сервер на `http://localhost:8123` и открывает
`altynka.html`. Из `file://` игра не работает: браузер запрещает странице
читать VRM-файл.

## Что внутри

- `altynka.html` — 3D-сцена: модель, перекраска волос и одежды, аксессуары,
  тату, поворот мышкой.
- `index.html` — 2D-версия игры (отмыть и одеть) на SVG.
- `v1-prototype.html` — первый прототип.
- `models/shino/` — VRM-модель.
- `three147.min.js`, `GLTFLoader.js`, `three-vrm.min.js` — движок локально.
- `serve.ps1`, `Запустить игру.bat` — локальный сервер.

## Управление

Потянуть мышкой — повернуть, колесо — зум.

## Лицензия модели

Sendagaya Shino, VRoid Project. Использование разрешено всем, включая
коммерческое, без указания автора. Подробности:
<https://hub.vroid.com/license?allowed_to_use_user=everyone&corporate_commercial_use=allow&credit=unnecessary&modification=allow&personal_commercial_use=profit&redistribution=allow>
