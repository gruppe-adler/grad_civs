#include "..\..\component.hpp"

// returns houses or roads or positions
_this params [
    ["_refPos", [0, 0]],
    ["_minDistance", 0],
    ["_maxDistance", 0],
    ["_numPositions", 1],
    ["_mode", ""] /* optional: house | road | none */
];

private _allPlayers = allPlayers - (entities "HeadlessClient_F");
private _halfSectorWidth = (_maxDistance - _minDistance) / 2;
private _initialSearchDir = random 360;
private _searchDirs = [];
_searchDirs resize _numPositions;

// get a bunch of positions at a medium distance from refpos (exactly in the middle between min distance and max distance)
_refPositions = _searchDirs apply {
    _initialSearchDir = (_initialSearchDir + (360 / _numPositions)) % 360;
    _initialSearchDir;
} apply {
    [
        (_refPos select 0) + _halfSectorWidth * sin _x,
        (_refPos select 1) + _halfSectorWidth * cos _x
    ];
} select {
    // ensure it's not in some other player's immediate vicinity or extremely far away from them
    ([_allPlayers, _x, _minDistance] call grad_civs_fnc_isInDistanceFromOtherPlayers);
};

// map to close roads or houses, if applicable
private _candidates = switch (_mode) do {
    case "road": {
        // for each position, get a road position close by
        _refPositions apply {
            _roadSegments = _x nearRoads _halfSectorWidth;
            if (count _roadSegments > 0) then {selectRandom _roadSegments} else {objNull};
        } select {
            !(isNull _x)
        };
    };
    case "house": {
        // for each position, get one uninhabited building close by
        _refPositions apply {
            private _houses = [_x, _halfSectorWidth, 2] call grad_civs_fnc_findBuildings;
            _houses = _houses select {
                (count (_x getVariable ["grad_civs_residents", []])) == 0
            };
            if (count _houses > 0) then {selectRandom _houses} else {objNull};
        } select {
            !(isNull _x);
        };
    };
    default {
        _refPositions
    };
};

// exclude all that are in at least one exclusion zone
{
    _candidates = _candidates - (_candidates inAreaArray _x);
} forEach GRAD_CIVS_EXCLUSION_ZONES;

_candidates
