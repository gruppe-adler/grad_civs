#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

LOGTIME_START("findSpawnPos_onFoot");
private _house = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCEONFOOTMIN,
    GRAD_CIVS_SPAWNDISTANCEONFOOTMAX,
    "house"
] call grad_civs_fnc_findSpawnPosition;
LOGTIME_END("findSpawnPos_onFoot");

if (isNull _house) exitWith {
    LOG("could not find house for patrol");
};

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;

LOGTIME_START("spawnCiv_onFoot");
_group = [getPos _house, _groupSize, objNull, _house, "patrol"] call grad_civs_fnc_spawnCivilianGroup;
LOGTIME_END("spawnCiv_onFoot");
