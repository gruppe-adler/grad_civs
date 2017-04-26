params [["_mode","runtime"]];

if (_mode == "preInit" && {([missionConfigFile >> "cfgGradCivs","autoInit",1] call BIS_fnc_returnConfigEntry) != 1}) exitWith {};

if (isServer) then {
    if (isNil "GRAD_CIVS_CLOTHES") then {missionNamespace setVariable ["GRAD_CIVS_CLOTHES",[missionConfigFile >> "cfgGradCivs","clothes",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_HEADGEAR") then {missionNamespace setVariable ["GRAD_CIVS_HEADGEAR",[missionConfigFile >> "cfgGradCivs","headgear",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_FACES") then {missionNamespace setVariable ["GRAD_CIVS_FACES",[missionConfigFile >> "cfgGradCivs","faces",[]] call BIS_fnc_returnConfigEntry,true]};
    if (isNil "GRAD_CIVS_GOGGLES") then {missionNamespace setVariable ["GRAD_CIVS_GOGGLES",[missionConfigFile >> "cfgGradCivs","goggles",[]] call BIS_fnc_returnConfigEntry,true]};

    missionNamespace setVariable ["GRAD_CIVS_EXITON",compile ([missionConfigFile >> "cfgGradCivs","exitOn",""] call BIS_fnc_returnConfigEntry),true];
    missionNamespace setVariable ["GRAD_CIVS_MAXCOUNT",[missionConfigFile >> "cfgGradCivs","maxCivs",""] call BIS_fnc_returnConfigEntry,true];
    missionNamespace setVariable ["GRAD_CIVS_DEBUGMODE",([missionConfigFile >> "cfgGradCivs","debugMode",0] call BIS_fnc_returnConfigEntry) == 1,false];

    _distances = [missionConfigFile >> "cfgGradCivs","spawnDistances",[1000,4500]] call BIS_fnc_returnConfigEntry;
    missionNamespace setVariable ["grad_civs_spawnDistanceMin",_distances select 0,true];
	missionNamespace setVariable ["grad_civs_spawnDistanceMax",_distances select 1,true];

    GRAD_CIVS_ONFOOTCOUNT = 0;
    GRAD_CIVS_ONFOOTGROUPS = [];

    [] call GRAD_civs_fnc_serverLoop;
};

if (hasInterface) then {
    missionNamespace setVariable ["GRAD_CIVS_DEBUGMODE",([missionConfigFile >> "cfgGradCivs","debugMode",0] call BIS_fnc_returnConfigEntry) == 1,false];

    [] call GRAD_civs_fnc_playerLoop;
    if (GRAD_CIVS_DEBUGMODE) then {[] call GRAD_civs_fnc_showWhatTheyThink};
};
