#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "9) diagnostics"];

[
    QGVAR(showOnMap),
    "CHECKBOX",
    "Show civs on map",
    _settingsGroup,
    false,
    true,
    FUNC(showOnMap),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showInfoLine),
    "CHECKBOX",
    "Show info line",
    _settingsGroup,
    false,
    true,
    FUNC(showInfoLine),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showPinkArrows),
    "CHECKBOX",
    "Helpfully hover arrows",
    _settingsGroup,
    false,
    true,
    FUNC(showPinkArrows),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showHonkAtArea),
    "CHECKBOX",
    "Draw honked at area",
    _settingsGroup,
    false,
    true,
    FUNC(showHonkAtArea),
    false
] call CBA_fnc_addSetting;
