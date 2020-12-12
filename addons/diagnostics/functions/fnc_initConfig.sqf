#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "c) diagnostics: debugging info"];

[
    QGVAR(showFps),
    "CHECKBOX",
    "Show server & HC fps",
    _settingsGroup,
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

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
    "Create 3D arrows over civ heads",
    _settingsGroup,
    false,
    true,
    FUNC(showPinkArrows),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showMisc),
    "CHECKBOX",
    "Miscellaneous stuff",
    _settingsGroup,
    false,
    true,
    FUNC(showHonkAtArea),
    false
] call CBA_fnc_addSetting;
