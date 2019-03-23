#include "..\..\component.hpp"

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance"];

if (count _allPlayers == 0) exitWith {INFO("_allPlayers is empty"); [0,0,0]};

private _refPos = [selectRandom _allPlayers, _minSpawnDistance, _maxSpawnDistance] call grad_civs_fnc_getRandomSpawnReferencePoint;

private _houses = [_refPos, _maxSpawnDistance - _minSpawnDistance, 2] call grad_civs_fnc_findBuildings;

private _validHouse = {
    private _house = _x;
    private _distancesAreOk = [_allPlayers, getPos _house, _minSpawnDistance, _maxSpawnDistance] call grad_civs_fnc_isAllowedSpawnPoint;
    private _existingResidents = _house getVariable ["grad_civs_residents", []];

    if (_distancesAreOk && (count _existingResidents == 0)) exitWith { _house };
} forEach _houses;
if (isNil "_validHouse") exitWith {objNull};

_validHouse
