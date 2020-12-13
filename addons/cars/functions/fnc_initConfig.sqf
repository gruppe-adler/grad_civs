#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "7) cars - basic settings for civilian drivers"];

[
    QGVAR(animalTransportChance),
    "SLIDER",
    "Suitable vehicles that will have animals as cargo",
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
    QGVAR(vehicles),
    "EDITBOX",
    "Classnames of vehicles that civilians may drive.",
    _settingsGroup,
    "[""C_Van_01_fuel_F"",""C_Hatchback_01_F"",""C_Truck_02_fuel_F"",""C_Truck_02_covered_F"",""C_Offroad_01_F"",""C_SUV_01_F"",""C_Van_01_transport_F"",""C_Van_01_box_F""]",
    true,
    {},
    false
] call CBA_fnc_addSetting;
