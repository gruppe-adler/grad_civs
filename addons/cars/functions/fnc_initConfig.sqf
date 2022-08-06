#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "7) cars - basic settings for civilian drivers"];

[
    QGVAR(vehicles),
    "EDITBOX",
    "Vehicles that civilians may drive (class names).",
    _settingsGroup,
    "[""C_Van_01_fuel_F"",""C_Hatchback_01_F"",""C_Truck_02_fuel_F"",""C_Truck_02_covered_F"",""C_Offroad_01_F"",""C_SUV_01_F"",""C_Van_01_transport_F"",""C_Van_01_box_F""]",
    true,
    {
        params ["_value"];
        GVAR(vehiclesArray) = [_value] call EFUNC(common,parseCsv);
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(animalTransportVehicles),
    "EDITBOX",
    "Vehicles with animals as cargo (class names)",
    _settingsGroup,
    "",
    true,
    {
        params ["_value"];
        GVAR(animalTransportVehiclesArray) = [_value] call EFUNC(common,parseCsv);
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(animalTransportChance),
    "SLIDER",
    "Ratio of suitable vehicles that will have animals as cargo",
    _settingsGroup,
    [0, 1, 0.4, 0, true],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(automaticVehicleGroupSize),
    "CHECKBOX",
    "Allow vehicles to be filled according to capacity",
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(globalSpeedLimit),
    "SLIDER",
    "Vehicle speed limit in km/h",
    _settingsGroup,
    [-1, 100, 20, 0, false],
    false,
    {},
    false
] call CBA_fnc_addSetting;
