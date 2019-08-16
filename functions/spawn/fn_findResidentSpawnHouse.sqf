/* return house or objNull */

#include "..\..\component.hpp"

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance"];

if (count _allPlayers == 0) exitWith {LOG("_allPlayers is empty"); objNull};

private _houses = [getPos (selectRandom _allPlayers), _minSpawnDistance, _maxSpawnDistance, 2, "house"] call grad_civs_fnc_findSpawnPositionCandidates;

if (count _houses > 0) then {
    selectRandom _houses;
} else {
    objNull;
}
