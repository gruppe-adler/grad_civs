#include "..\script_component.hpp"

if (CBA_missionTime - (_this getVariable [QGVAR(lastDespawnCheck), 0]) < 10) exitWith {};
_this setVariable [QGVAR(lastDespawnCheck), CBA_missionTime];

LOG_1("check despawn cond for %1", _this);

if (_this getVariable ["grad_civs_excludeFromCleanup",false]) exitWith {false};

private _type = _this getVariable ["grad_civs_primaryTask", ""];
private _civTaskTypeInfo = EGVAR(common,civTaskTypes) getVariable [_type, []];
_civTaskTypeInfo params [
    ["_cleanupDistance", 99999, [0]],
    ["_despawnCondition", {false}, [{}]]
];

private _tooDistantFromPlayers = false;
if ((count ALL_HUMAN_PLAYERS > 0) || ([QGVAR(spawnOnlyWithPlayers)] call CBA_settings_fnc_get)) then {
    if ([ALL_HUMAN_PLAYERS, getPos _this, _cleanupDistance] call FUNC(isInDistanceFromOtherPlayers)) then {
        INFO_1("despawning civ %1 based on distance", _this);
        _tooDistantFromPlayers = true;
    };
} else {
    INFO("no human players connected, but civs allowed - will abstain from despawning civilians based on player distance");
};

_tooDistantFromPlayers || {_this call _despawnCondition}
