#include "..\..\component.hpp"

// returns houses or roads or positions
_this params [
    ["_allPlayers", []],
    ["_minDistance", 0],
    ["_maxDistance", 0],
    ["_mode", ""] /* optional: house | road | none */
];

private _halfSectorWidth = (_maxDistance - _minDistance) / 2;
private _initialSearchDir = random 360;

// create bunch of equidistant points with center at [0,0]
private _searchDirs = [];
_searchDirs resize 3;
private _searchDistancePoints = _searchDirs apply {
    _initialSearchDir = ((_initialSearchDir + (360/3)) % 360);
    _initialSearchDir
} apply {
    [
        (_minDistance + _halfSectorWidth) * sin _x,
        (_minDistance + _halfSectorWidth) * cos _x,
        0
    ]
};

private _shuffledPlayers = _allPlayers call BIS_fnc_arrayShuffle;
private _result = {
    // try to find houses - and abort when we found one thats good
    private _refPlayer = _x;
    private _result = {
        private _refPos = (getPos _refPlayer) vectorAdd _x;
        LOG_3("looking for spawn pos around %1 which is pos#%2 derived from player %3 ", _refPos, _forEachIndex, _refPlayer);

        private _candidate = switch (_mode) do {
            case "road": {
                // for each position, get a road position close by
                private _road = selectRandom (_refPos nearRoads _halfSectorWidth);
                if (count (_road nearEntities ["Man", 100]) == 0) then {
                    _road
                } else {
                    objNull
                }
            };
            case "house": {
                ([_refPos, _halfSectorWidth] call grad_civs_fnc_findUnclaimedHouse)
            };
            default {
                _refPos
            };
        };
        LOG_1("_candidate (before vetting): %1", _candidate);
        if ((!(isNull _candidate))
            && {
                LOG_3("_allPlayers: %1, _candidate %2, _minDistance %3", _allPlayers, getPos _candidate, _minDistance);
                [_allPlayers, _candidate, _minDistance] call FUNC(isInDistanceFromOtherPlayers)
            }
            && {
                [getPos _candidate] call FUNC(isInPopulatedZone)
            }
        ) exitWith {
            LOG_1("found spawn position %1", _candidate);
            _candidate
        };
        LOG_3("could not find spawn position at %1 within %2 m in %3 mode", _refPos, _halfSectorWidth, _mode);
        objNull
    } forEach _searchDistancePoints;
    if (!(isNull _result)) exitWith {_result}; objNull
} forEach _shuffledPlayers;

_result
