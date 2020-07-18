#include "..\script_component.hpp"

private _idx =  GVAR(localCivs) find _this;

if (_idx == -1) exitWith {false}; // should not happen, really

if (((floor CBA_missionTime) mod 10) != (_idx mod 10)) exitWith {false}; // check only every 10s for a given unit

if (_this getVariable ["grad_civs_excludeFromCleanup",false]) exitWith {false};

scopeName "main";

private _type = _this getVariable ["grad_civs_primaryTask", ""];
private _civTaskTypeInfo = EGVAR(common,civTaskTypes) getVariable [_type, []];
_civTaskTypeInfo params [
    ["_cleanupDistance", 99999, [0]],
    ["_despawnCondition", {false}, [{}]]
];

private _tooDistantFromPlayers = false;
if ((count ALL_HUMAN_PLAYERS > 0) || ([QGVAR(spawnOnlyWithPlayers)] call CBA_settings_fnc_get)) then {
    if ([ALL_HUMAN_PLAYERS, getPos _this, _cleanupDistance] call FUNC(isInDistanceFromOtherPlayers)) then {
        INFO("despawning civ based on distance");
        _tooDistantFromPlayers = true;
        breakTo "main";
    };
} else {
    INFO("no human players connected, but civs allowed - will abstain from despawning civilians based on player distance");
};

_tooDistantFromPlayers || {_this call _despawnCondition}
