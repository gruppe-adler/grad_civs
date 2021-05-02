#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "a) transit - traffic between pre-set points"];

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
    {
        params ["_vehicles"];
        GVAR(vehiclesArray) = [_vehicles] call EFUNC(common,parseCsv);
    },
    false
] call CBA_fnc_addSetting;
