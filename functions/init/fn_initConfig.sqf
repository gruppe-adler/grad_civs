#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "preInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initConfig right now...")};

assert(isClass (configFile >> "CfgWeapons" >> "ACE_Banana")); // we depend on ACE

if !(([missionConfigFile, "corpseManagerMode", -1] call BIS_fnc_returnConfigEntry) in [1, 3]) then {
    INFO("'corpseManagerMode' is switched off for all units, but grad-civs will add its corpses anyway");
};

INFO("Civs initConfig running...");

if (isNil QGVAR(CIVCLASS)) then {missionNamespace setVariable [QGVAR(CIVCLASS),[missionConfigFile >> "cfgGradCivs","civClass","C_man_1"] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_CLOTHES") then {missionNamespace setVariable ["GRAD_CIVS_CLOTHES",[missionConfigFile >> "cfgGradCivs","clothes",[]] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_HEADGEAR") then {missionNamespace setVariable ["GRAD_CIVS_HEADGEAR",[missionConfigFile >> "cfgGradCivs","headgear",[]] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_FACES") then {missionNamespace setVariable ["GRAD_CIVS_FACES",[missionConfigFile >> "cfgGradCivs","faces",[]] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_GOGGLES") then {missionNamespace setVariable ["GRAD_CIVS_GOGGLES",[missionConfigFile >> "cfgGradCivs","goggles",[]] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_BACKPACKS") then {missionNamespace setVariable ["GRAD_CIVS_BACKPACKS",[missionConfigFile >> "cfgGradCivs","backpacks",[]] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_VEHICLES") then {missionNamespace setVariable [
    "GRAD_CIVS_VEHICLES",
    [
        missionConfigFile >> "cfgGradCivs",
        "vehicles",
        ["C_Van_01_fuel_F", "C_Hatchback_01_F", "C_Offroad_02_unarmed_F", "C_Truck_02_fuel_F", "C_Truck_02_covered_F", "C_Offroad_01_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F"]
    ] call BIS_fnc_returnConfigEntry
]};

if (isNil "GRAD_CIVS_BACKPACKPROBABILITY") then {missionNamespace setVariable ["GRAD_CIVS_BACKPACKPROBABILITY",[missionConfigFile >> "cfgGradCivs","backpackProbability",0.5] call BIS_fnc_returnConfigEntry]};

if (isNil "GRAD_CIVS_DEBUG_CIVSTATE") then {missionNamespace setVariable ["GRAD_CIVS_DEBUG_CIVSTATE",([missionConfigFile >> "cfgGradCivs","debugCivState",0] call BIS_fnc_returnConfigEntry) == 1]};
if (isNil "GRAD_CIVS_DEBUG_FPS") then {missionNamespace setVariable ["GRAD_CIVS_DEBUG_FPS",([missionConfigFile >> "cfgGradCivs","debugFps",0] call BIS_fnc_returnConfigEntry) == 1]};

if (isNil "GRAD_CIVS_MINFPS") then {missionNamespace setVariable ["GRAD_CIVS_MINFPS", [missionConfigFile >> "cfgGradCivs","minFps", 35] call BIS_fnc_returnConfigEntry]};
if (isNil "GRAD_CIVS_MINCIVUPDATETIME") then {missionNamespace setVariable ["GRAD_CIVS_MINCIVUPDATETIME", [missionConfigFile >> "cfgGradCivs","minCivUpdateTime", 3] call BIS_fnc_returnConfigEntry]};

missionNamespace setVariable ["GRAD_CIVS_ENABLEDONFOOT",([missionConfigFile >> "cfgGradCivs","enableOnFoot",1] call BIS_fnc_returnConfigEntry) == 1];
missionNamespace setVariable ["GRAD_CIVS_ENABLEDINVEHICLES",([missionConfigFile >> "cfgGradCivs","enableInVehicles",1] call BIS_fnc_returnConfigEntry) == 1];

missionNamespace setVariable ["GRAD_CIVS_MAXCIVSONFOOT",[missionConfigFile >> "cfgGradCivs","maxCivsOnFoot",30] call BIS_fnc_returnConfigEntry];
missionNamespace setVariable ["GRAD_CIVS_MAXCIVSINVEHICLES",[missionConfigFile >> "cfgGradCivs","maxCivsInVehicles",10] call BIS_fnc_returnConfigEntry];
missionNamespace setVariable ["GRAD_CIVS_MAXCIVSRESIDENTS", [missionConfigFile >> "cfgGradCivs","maxCivsResidents", 20] call BIS_fnc_returnConfigEntry];

missionNamespace setVariable ["GRAD_CIVS_EXITON",compile ([missionConfigFile >> "cfgGradCivs","exitOn",""] call BIS_fnc_returnConfigEntry)];
missionNamespace setVariable ["GRAD_CIVS_ONSPAWN",compile ([missionConfigFile >> "cfgGradCivs","onSpawn",""] call BIS_fnc_returnConfigEntry)];
missionNamespace setVariable ["GRAD_CIVS_ONHELDUP",compile ([missionConfigFile >> "cfgGradCivs","onHeldUp",""] call BIS_fnc_returnConfigEntry)];
missionNamespace setVariable ["GRAD_CIVS_ONKILLED",compile ([missionConfigFile >> "cfgGradCivs","onKilled",""] call BIS_fnc_returnConfigEntry)];

_initialGroupSize = [missionConfigFile >> "cfgGradCivs","initialGroupSize", 3] call BIS_fnc_returnConfigEntry;
if (typeName _initialGroupSize == "SCALAR") then { _initialGroupSize = _initialGroupSize + 1 };
missionNamespace setVariable ["GRAD_CIVS_INITIALGROUPSIZE", _initialGroupSize];
missionNamespace setVariable ["GRAD_CIVS_AUTOMATICVEHICLEGROUPSIZE", ([missionConfigFile >> "cfgGradCivs","automaticVehicleGroupSize", 1] call BIS_fnc_returnConfigEntry) == 1];
missionNamespace setVariable ["GRAD_CIVS_PANICCOOLDOWN", ([missionConfigFile >> "cfgGradCivs", "panicCooldown", [15, 120, 240]] call BIS_fnc_returnConfigEntry)];

_distances = [missionConfigFile >> "cfgGradCivs","spawnDistancesResidents",[50, 750]] call BIS_fnc_returnConfigEntry;
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCERESIDENTMIN",_distances select 0];
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCERESIDENTMAX",_distances select 1];

_distances = [missionConfigFile >> "cfgGradCivs","spawnDistancesOnFoot",[1000,4500]] call BIS_fnc_returnConfigEntry;
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEONFOOTMIN",_distances select 0];
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEONFOOTMAX",_distances select 1];

_distances = [missionConfigFile >> "cfgGradCivs","spawnDistancesInVehicles",[1500,6000]] call BIS_fnc_returnConfigEntry;
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN",_distances select 0];
missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX",_distances select 1];

GRAD_CIVS_BUS_MEETNEIGHBOR_COOLDOWN = 150;
GRAD_CIVS_CHAT_TIME = 20;
GVAR(EXCLUSION_ZONES) = [];
GVAR(POPULATION_ZONES) = [];
