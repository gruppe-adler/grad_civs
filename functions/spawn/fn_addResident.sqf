#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

private _house = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMIN,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMAX
] call grad_civs_fnc_findResidentSpawnHouse;

if (isNil "_house") exitWith {LOG("could not find spawn position for resident this time (nil)")};
if (isNull _house) exitWith {LOG("could not find spawn position for resident this time (null)")};

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;

private _group = [getPos _house, _groupSize, objNull, _house, "reside"] call grad_civs_fnc_spawnCivilianGroup;
if (isNull _group) exitWith {};

_group
