#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "9) transit"];

[
    QGVAR(maxVehiclesInTransit),
    "SLIDER",
    "Maximum number of vehicles on transit routes",
    _settingsGroup,
    [0, 100, 5, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(vehicles),
    "EDITBOX",
    "Vehicle classes for transit (optional)",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;
