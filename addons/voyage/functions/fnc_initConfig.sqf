#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "5) voyagers"];

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
    QGVAR(maxCivsInVehicles),
    "SLIDER",
    "Maximum total number of civilian voyagers",
    _settingsGroup,
    [0, 300, 10, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnDistancesInVehicles),
    "EDITBOX",
    "Spawn distance ([min,max])",
    _settingsGroup,
    QUOTE(ARR_2([1500,6000])),
    false,
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
