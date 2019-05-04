#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

LOGTIME_START("findSpawnPos_onFoot");
_pos = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCEONFOOTMIN,
    GRAD_CIVS_SPAWNDISTANCEONFOOTMAX,
    ["patrol"] call grad_civs_fnc_getGlobalCivs
] call grad_civs_fnc_findSpawnPosition;
LOGTIME_END("findSpawnPos_onFoot");

if (_pos isEqualTo [0,0,0]) exitWith {};

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;

LOGTIME_START("spawnCiv_onFoot");
_group = [_pos, _groupSize, objNull, "patrol"] call grad_civs_fnc_spawnCivilianGroup;
LOGTIME_END("spawnCiv_onFoot");
