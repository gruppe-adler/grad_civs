#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "8) voyagers - AI driving unleashed"];

[
    QGVAR(maxCivsInVehicles),
    "SLIDER",
    "Maximum total number of civilian voyagers",
    _settingsGroup,
    [0, 300, 10, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnDistancesInVehicles),
    "EDITBOX",
    "Spawn distance ([min,max])",
    _settingsGroup,
    QUOTE(ARR_2([1500,6000])),
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(maxTravelRadius),
    "SLIDER",
    "max travel radius around spawn (optional)",
    _settingsGroup,
    [0, 100000, 0, 0],
    false,
    {},
    false
] call CBA_fnc_addSetting;
