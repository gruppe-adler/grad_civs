#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "b) player mimikry - help with acting like a grad-civ"];

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
