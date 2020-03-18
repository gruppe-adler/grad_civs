/*return road segment where one can spawn, or objNull */
#include "..\..\component.hpp"

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance", "_civilians"];

if (_allPlayers isEqualTo []) exitWith {LOG("_allPlayers is empty"); objNull};

private _refPlayerPos = getPos (selectRandom _allPlayers);

([_allPlayers - (entities "HeadlessClient_F"), _minSpawnDistance, _maxSpawnDistance, "road"] call grad_civs_fnc_findSpawnPosition);
