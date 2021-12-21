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
