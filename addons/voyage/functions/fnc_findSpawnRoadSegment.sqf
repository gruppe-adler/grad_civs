#include "..\script_component.hpp"

/*return road segment where one can spawn, or objNull */

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance", "_civilians"];

if (_allPlayers isEqualTo []) exitWith {LOG("_allPlayers is empty"); objNull};

private _refPlayerPos = getPos (selectRandom _allPlayers);

([ALL_HUMAN_PLAYERS, _minSpawnDistance, _maxSpawnDistance, "road"] call EFUNC(lifecycle,findSpawnPosition));
