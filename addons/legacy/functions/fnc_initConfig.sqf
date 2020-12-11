#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "2) basics"];

[
    QGVAR(panicCooldown),
    "EDITBOX",
    "Time for panic to wear off [low, med, high]",
    _settingsGroup,
    QUOTE([ARR_3(15,120,240)]),
    false,
    {},
    false
] call CBA_fnc_addSetting;
