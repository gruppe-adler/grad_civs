#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "7) player mimikry"];

[
    QGVAR(enabled),
    "CHECKBOX",
    "Enable player mimikry",
    _settingsGroup,
    true,
    true,
    {},
    true
] call CBA_fnc_addSetting;
