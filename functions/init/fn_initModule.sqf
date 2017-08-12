#include "..\..\component.hpp"

params [["_mode","runtime"]];

if (_mode == "preInit" && {([missionConfigFile >> "cfgGradCivs","autoInit",1] call BIS_fnc_returnConfigEntry) != 1}) exitWith {};

INFO("Module starting...");

if (isServer) then {
    if (isNil "GRAD_CIVS_CLOTHES") then {missionNamespace setVariable ["GRAD_CIVS_CLOTHES",[missionConfigFile >> "cfgGradCivs","clothes",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_HEADGEAR") then {missionNamespace setVariable ["GRAD_CIVS_HEADGEAR",[missionConfigFile >> "cfgGradCivs","headgear",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_FACES") then {missionNamespace setVariable ["GRAD_CIVS_FACES",[missionConfigFile >> "cfgGradCivs","faces",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_GOGGLES") then {missionNamespace setVariable ["GRAD_CIVS_GOGGLES",[missionConfigFile >> "cfgGradCivs","goggles",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_BACKPACKS") then {missionNamespace setVariable ["GRAD_CIVS_BACKPACKS",[missionConfigFile >> "cfgGradCivs","backpacks",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_VEHICLES") then {missionNamespace setVariable ["GRAD_CIVS_VEHICLES",[missionConfigFile >> "cfgGradCivs","vehicles",[]] call BIS_fnc_returnConfigEntry,true]};

    if (isNil "GRAD_CIVS_BACKPACKPROBABILITY") then {missionNamespace setVariable ["GRAD_CIVS_BACKPACKPROBABILITY",[missionConfigFile >> "cfgGradCivs","backpackProbability",0.5] call BIS_fnc_returnConfigEntry,true]};

    if (isNil "GRAD_CIVS_DEBUGMODE") then {missionNamespace setVariable ["GRAD_CIVS_DEBUGMODE",([missionConfigFile >> "cfgGradCivs","debugMode",0] call BIS_fnc_returnConfigEntry) == 1,false]};

    missionNamespace setVariable ["GRAD_CIVS_ENABLEDONFOOT",([missionConfigFile >> "cfgGradCivs","enableOnFoot",1] call BIS_fnc_returnConfigEntry) == 1];
    missionNamespace setVariable ["GRAD_CIVS_ENABLEDINVEHICLES",([missionConfigFile >> "cfgGradCivs","enableInVehicles",1] call BIS_fnc_returnConfigEntry) == 1];

    missionNamespace setVariable ["GRAD_CIVS_MAXCIVSONFOOT",[missionConfigFile >> "cfgGradCivs","maxCivsOnFoot",30] call BIS_fnc_returnConfigEntry,true];
    missionNamespace setVariable ["GRAD_CIVS_MAXCIVSINVEHICLES",[missionConfigFile >> "cfgGradCivs","maxCivsInVehicles",10] call BIS_fnc_returnConfigEntry,true];

    missionNamespace setVariable ["GRAD_CIVS_EXITON",compile ([missionConfigFile >> "cfgGradCivs","exitOn",""] call BIS_fnc_returnConfigEntry),true];
    missionNamespace setVariable ["GRAD_CIVS_ONSPAWN",compile ([missionConfigFile >> "cfgGradCivs","onSpawn",""] call BIS_fnc_returnConfigEntry),true];
    missionNamespace setVariable ["GRAD_CIVS_ONHELDUP",compile ([missionConfigFile >> "cfgGradCivs","onHeldUp",""] call BIS_fnc_returnConfigEntry),true];

    _distances = [missionConfigFile >> "cfgGradCivs","spawnDistancesOnFoot",[1000,4500]] call BIS_fnc_returnConfigEntry;
    missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEONFOOTMIN",_distances select 0,true];
	missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEONFOOTMAX",_distances select 1,true];

    _distances = [missionConfigFile >> "cfgGradCivs","spawnDistancesInVehicles",[1500,6000]] call BIS_fnc_returnConfigEntry;
    missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN",_distances select 0,true];
	missionNamespace setVariable ["GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX",_distances select 1,true];

    GRAD_CIVS_ONFOOTCOUNT = 0;
    GRAD_CIVS_ONFOOTUNITS = [];

    GRAD_CIVS_INVEHICLESCOUNT = 0;
    GRAD_CIVS_INVEHICLESUNITS = [];

    [] call grad_civs_fnc_serverLoop;
};

if (hasInterface) then {
    if (isNil "GRAD_CIVS_DEBUGMODE") then {missionNamespace setVariable ["GRAD_CIVS_DEBUGMODE",([missionConfigFile >> "cfgGradCivs","debugMode",0] call BIS_fnc_returnConfigEntry) == 1,false]};

    [] call grad_civs_fnc_playerLoop;
    if (GRAD_CIVS_DEBUGMODE) then {
        [] call grad_civs_fnc_showWhatTheyThink;
        [{!isNull (findDisplay 12)}, {[] call grad_civs_fnc_mapMarkers}, []] call CBA_fnc_waitUntilAndExecute;
    };
};
