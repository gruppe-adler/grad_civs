#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "5) residents - between housework and chats with the neighbors"];


[
    QGVAR(maxCivsResidents),
    "SLIDER",
    "Max number of civilian residents",
    _settingsGroup,
    [0, 300, 20, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnDistancesResidents),
    "EDITBOX",
    "Spawn distance ([min,max])",
    _settingsGroup,
    QUOTE(ARR_2([500, 1000])),
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(chatTime),
    "SLIDER",
    "How long civilian chats can last",
    _settingsGroup,
    [5, 900, 20, 0],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(meetNeighborCooldown),
    "SLIDER",
    "Time between visiting neighbors",
    _settingsGroup,
    [5, 3600, 150, 0],
    false,
    {},
    false
] call CBA_fnc_addSetting;
