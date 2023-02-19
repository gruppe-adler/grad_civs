#include "..\script_component.hpp"

private _settingsGroup = ["GRAD Civilians", "1) main"];

[
    QGVAR(enabled),
    "CHECKBOX",
    "Enable grad_civs",
    _settingsGroup,
    false,
    true,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(clockrate),
    "SLIDER",
    ["Clock Rate", "Time in seconds between spawn attempts"],
    _settingsGroup,
    [0.25,10,2, 2],
    true,
    {},
    false
] call CBA_fnc_addSetting;
