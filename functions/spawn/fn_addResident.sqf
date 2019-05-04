#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

private _house = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMIN,
    GRAD_CIVS_SPAWNDISTANCERESIDENTMAX
] call grad_civs_fnc_findResidentSpawnHouse;

if (isNil "_house") exitWith {INFO("could not find spawn position for resident this time")};
if (isNull _house) exitWith {INFO("could not find spawn position for resident this time")};

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;

private _group = [getPos _house, _groupSize, objNull, "reside"] call grad_civs_fnc_spawnCivilianGroup;
if (isNull _group) exitWith {};

_house setVariable ["grad_civs_residents", units _group, true];
{
    _x setVariable ["grad_civs_home", _house, true];
} forEach units _group;

_group
