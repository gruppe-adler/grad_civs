#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "7) cars - basic settings for civilian drivers"];

[
    QGVAR(vehiclesSettingString),
    "EDITBOX",
    "Vehicles that civilians may drive (class names).",
    _settingsGroup,
    "[""C_Van_01_fuel_F"",""C_Hatchback_01_F"",""C_Truck_02_fuel_F"",""C_Truck_02_covered_F"",""C_Offroad_01_F"",""C_SUV_01_F"",""C_Van_01_transport_F"",""C_Van_01_box_F""]",
    true,
    {
        params ["_value"];
        GVAR(vehicles) = [_value] call EFUNC(common,parseCsv);
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(animalTransportVehiclesSettingString),
    "EDITBOX",
    "Vehicles with animals as cargo (class names)",
    _settingsGroup,
    "",
    true,
    {
        params ["_value"];
        GVAR(animalTransportVehicles) = [_value] call EFUNC(common,parseCsv);
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

