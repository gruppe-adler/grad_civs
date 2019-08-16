/*return road segment where one can spawn, or objNull */
#include "..\..\component.hpp"

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance", "_civilians"];

if (count _allPlayers == 0) exitWith {LOG("_allPlayers is empty"); objNull};

private _refPlayerPos = getPos (selectRandom _allPlayers);
private _roads = [_refPlayerPos, _minSpawnDistance, _maxSpawnDistance, 2, "road"] call grad_civs_fnc_findSpawnPositionCandidates;

// make sure the travelers dont spawn close to other civs. necessary? not sure. maybe yes.
_roads = _roads select {
    private _road = _x;
    {
        if ((_road distance _x) < 100) exitWith {false};
        true
    } forEach (_civilians + [[0, 0, 0]]);
};

if ((count _roads) > 0) then {
    // return one spawn position of road
    selectRandom _roads
} else {
    objNull
}
