#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "9) GTA - vehicles have owners now"];

[
    QGVAR(enabled),
    "CHECKBOX",
    "Enable auto theft events",
    _settingsGroup,
    true,
    true,
    {},
    true
] call CBA_fnc_addSetting;

/*
[
    QGVAR(carOwnershipRatio),
    "SLIDER",
    "Ratio of civs who will own (and not use) cars",
    _settingsGroup,
    [0, 1, 0.2, 0, true],
    true,
    {},
    false
] call CBA_fnc_addSetting;
*/