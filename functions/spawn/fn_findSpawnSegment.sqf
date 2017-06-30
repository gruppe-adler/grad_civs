#include "..\..\component.hpp"

params ["_allPlayerPositions", "_minSpawnDistance", "_maxSpawnDistance", "_civilianGroups"];

if (count _allPlayerPositions == 0) exitWith {INFO("_allPlayerPositions is empty"); [0,0,0]};

private _spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
private _roadSegment = objNull;
private _refPlayerPos = selectRandom _allPlayerPositions;


for [{_i=0}, {_i<20}, {_i=_i+1}] do {
    _dir = random 360;

    _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
    _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;

    _roadSegments = [_refPosX, _refPosY] nearRoads (_spawnDistanceDiff / 2);
    _roadSegment = if (count _roadSegments > 0) then {selectRandom _roadSegments} else {objNull};

    _inSpawnZone = {
        {
            _roadPos = getPos _roadSegment;
            if (_x distance _roadPos < _minSpawnDistance) exitWith {false};
            if (_x distance _roadPos > _maxSpawnDistance) exitWith {false};
            true
        } forEach _allPlayerPositions;
    };

    _awayFromOtherCivs = {
        {
            _unit = (units _x) param [0,objNull];
            if ((getPos _roadSegment) distance _unit < 100) exitWith {false};
            true
        } forEach _civilianGroups;
    };

    if (!isNull _roadSegment && _inSpawnZone && _awayFromOtherCivs) exitWith {};
};


getPos _roadSegment
