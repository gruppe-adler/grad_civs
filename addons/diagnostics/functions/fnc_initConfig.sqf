#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "c) diagnostics - debugging info"];

[
    QGVAR(showFps),
    "CHECKBOX",
    "Show server & HC fps",
    _settingsGroup,
    false,
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showOnMap),
    "CHECKBOX",
    "Show civs on map",
    _settingsGroup,
    false,
    false,
    FUNC(showOnMap),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showInfoLine),
    "CHECKBOX",
    "Show info line",
    _settingsGroup,
    false,
    false,
    FUNC(showInfoLine),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showPinkArrows),
    "CHECKBOX",
    "Create 3D arrows over civ heads",
    _settingsGroup,
    false,
    false,
    FUNC(showPinkArrows),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showMisc),
    "CHECKBOX",
    "Miscellaneous stuff",
    _settingsGroup,
    false,
    false,
    FUNC(showHonkAtArea),
    false
] call CBA_fnc_addSetting;
