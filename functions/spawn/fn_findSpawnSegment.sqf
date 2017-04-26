/* blatantly ripped and modified from engima traffic */

#include "..\..\component.hpp"

private ["_refPlayerPos", "_roadSegments", "_roadSegment", "_isOk", "_tries", "_result", "_spawnDistanceDiff", "_refPosX", "_refPosY", "_dir", "_tooFarAwayFromAll", "_tooClose", "_tooCloseToAnotherVehicle"];

//
params ["_allPlayerPositions", "_minSpawnDistance", "_maxSpawnDistance", "_civilianGroups"];

if (count _allPlayerPositions == 0) exitWith { INFO("_allPlayerPositions is empty"); [0,0,0] };

_spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
_roadSegment = "NULL";
_refPlayerPos = (_allPlayerPositions select floor random count _allPlayerPositions);

if (isNil "_refplayerpos") exitWith { INFO("refplayerpos is nil"); };

_isOk = false;
_tries = 0;

while {!_isOk} do {
    _isOk = true;

    _dir = random 360;

    _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
    _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;

    _roadSegments = [_refPosX, _refPosY] nearRoads (_spawnDistanceDiff / 2);

    if (count _roadSegments > 0) then {
        _roadSegment = _roadSegments select floor random count _roadSegments;

        // Check if road segment is ok
        _tooFarAwayFromAll = true;
        _tooClose = false;
        _tooCloseToAnotherVehicle = false;




        {
            private ["_tooFarAway"];

            _tooFarAway = false;

            if (_x distance (getPos _roadSegment) < _minSpawnDistance) then {
                _tooClose = true;
            };
            if (_x distance (getPos _roadSegment) > _maxSpawnDistance) then {
                _tooFarAway = true;
            };
            if (!_tooFarAway) then {
                _tooFarAwayFromAll = false;
            };

            sleep 0.01;
        } foreach _allPlayerPositions;

        {
            private ["_unit"];
            if (count units _x == 0) exitWith {
                INFO("grad_civs empty group");
            };
            _unit = (units _x) select 0;

            if ((getPos _roadSegment) distance _unit < 100) then {
                _tooCloseToAnotherVehicle = true;
            };

            sleep 0.01;
        } foreach _civilianGroups;


        _isOk = true;

        if (_tooClose || _tooFarAwayFromAll || _tooCloseToAnotherVehicle) then {
            _isOk = false;
            _tries = _tries + 1;
        };
    }
    else {
        _isOk = false;
        _tries = _tries + 1;
    };

	sleep 0.1;
};

_result = getPos _roadSegment;

INFO_2("found spawn %2 for civ in %1 tries", _tries, _result);

_result
