#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "8) gta"];

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