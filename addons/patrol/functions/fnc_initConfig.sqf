#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "6) patrols - going for long walks"];

[
    QGVAR(maxCivsOnFoot),
    "SLIDER",
    "Max number of civilians patroling on foot",
    _settingsGroup,
    [0, 300, 30, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(initialGroupSize),
    "SLIDER",
    "Max group size for civilians",
    _settingsGroup,
    [0, 50, 3, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnDistancesOnFoot),
    "EDITBOX",
    "Spawn distance ([min,max])",
    _settingsGroup,
    QUOTE(ARR_2([1000,4500])),
    false,
    {},
    false
] call CBA_fnc_addSetting;
