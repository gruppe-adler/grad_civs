#include "..\..\component.hpp"

params ["_allPlayers", "_minSpawnDistance", "_maxSpawnDistance", "_civilianGroups"];

if (count _allPlayers == 0) exitWith {INFO("_allPlayers is empty"); [0,0,0]};

private _spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
private _roadSegment = objNull;
private _roadPos = [0,0,0];
private _refPlayerPos = getPos (selectRandom _allPlayers);

//only 1 repetition for performance reasons >> kept for loop in case we want to bump it up again
for [{_i=0}, {_i<1}, {_i=_i+1}] do {
    _dir = random 360;

    _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
    _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;

    _roadSegments = [_refPosX, _refPosY] nearRoads (_spawnDistanceDiff / 2);
    _roadSegment = if (count _roadSegments > 0) then {selectRandom _roadSegments} else {objNull};
    _roadPos = getPos _roadSegment;

    _inSpawnZone = {
        {
            if (_x distance _roadPos < _minSpawnDistance) exitWith {false};
            if (_x distance _roadPos > _maxSpawnDistance) exitWith {false};
            true
        } forEach _allPlayers;
    };

    _awayFromOtherCivs = {
        {
            _unit = (units _x) param [0,objNull];
            if (_roadPos distance _unit < 100) exitWith {false};
            true
        } forEach _civilianGroups;
    };

    if (!isNull _roadSegment && _inSpawnZone && _awayFromOtherCivs) exitWith {};
};

_roadPos
