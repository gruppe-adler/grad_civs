#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

private _house = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMIN,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMAX,
    "house"
] call grad_civs_fnc_findSpawnPosition;

if (isNil "_house") exitWith {LOG("could not find spawn position for resident this time (nil)")};
if (isNull _house) exitWith {LOG("could not find spawn position for resident this time (null)")};

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;

private _group = [getPos _house, _groupSize, objNull, _house, "reside"] call FUNC(spawnCivilianGroup);
if (isNull _group) exitWith {};

_group
