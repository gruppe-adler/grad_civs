#include "..\script_component.hpp"

ISNILS(GVAR(minRoadSpawnManSpawnDistance), 20);

/**

    returns false or HashMap of {
        "house" : Object
        "road" : Object
        "civClasses": []string
        "vehicleClasses": []string
    }
 */

_this params [
    ["_allPlayers", []],
    ["_minDistance", 0],
    ["_maxDistance", 0],
    ["_mode", ""] /* optional: house | road */
];

assert(_minDistance <= _maxDistance);

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
// TODO: handle playercount == 0
LOG_1("Filtering all players to find suitable spawn point candidates", _allPlayers);
private _filteredPlayers = [_allPlayers] call FUNC(filterPlayers);
LOG_1("Filtered players to %1", _filteredPlayers);
if (count _filteredPlayers isEqualTo 0) exitWith {false};

private _shuffledPlayers = _filteredPlayers call BIS_fnc_arrayShuffle;
private _result = {
    // try to find houses - and abort when we found one thats good
    private _refPlayer = _x;
    private _result = {
        private _refPos = (getPos _refPlayer) vectorAdd _x;
        LOG_3("looking for spawn pos around %1 which is pos#%2 derived from player %3 ", _refPos, _forEachIndex, _refPlayer);

        [QGVAR(spawnRefpos), [_mode, _refPos]] call CBA_fnc_localEvent;

        private _candidate = switch (_mode) do {
            case "road": {
                // for each position, get a road position close by
                private _road = selectRandom (_refPos nearRoads _halfSectorWidth);
                if (count (_road nearEntities ["Man", GVAR(minRoadSpawnManSpawnDistance)]) == 0) then {
                    _road
                } else {
                    objNull
                }
            };
            case "house": {
                ([_refPos, _halfSectorWidth, false] call FUNC(findUnclaimedHouse))
            };
            default {
                WARNING_1("invalid mode '%1' provided to findSpawnPosition", _mode);
                objNull
            };
        };

        [QGVAR(spawnCandidate), [_mode, _refPos, _candidate]] call CBA_fnc_localEvent;

        LOG_1("_candidate (before vetting): %1", _candidate);
        private _popZones = [];
        if ((!(isNull _candidate))
            && {
                LOG_3("_allPlayers: %1, _candidate %2, _minDistance %3", _allPlayers, getPos _candidate, _minDistance);
                private _minDistanceIsGiven = [_allPlayers, _candidate, _minDistance] call FUNC(isInDistanceFromOtherPlayers);

                [QGVAR(spawnCandidateMinDistance), [_mode, _refPos, _candidate, _minDistanceIsGiven]] call CBA_fnc_localEvent;

                _minDistanceIsGiven
            }
        ) then {
            _popZones = [getPos _candidate] call EFUNC(common,getPopulationZones);
        };
        if (count _popZones > 0) exitWith {

            [QGVAR(spawnCandidatePopzone), [_mode, _refPos, _candidate]] call CBA_fnc_localEvent;

            LOG_1("found spawn position %1", _candidate);
            private _hashMap = [
                "house",
                "road",
                "civClasses",
                "vehicleClasses"
            ] createHashMapFromArray [
                objNull,
                objNull,
                flatten (_popZones apply {_x get "civClasses"}),
                flatten (_popZones apply {_x get "vehicleClasses"})
            ];
            _hashMap set [_mode, _candidate];
            _hashMap
        };
        LOG_3("could not find spawn position at %1 within %2 m in %3 mode", _refPos, _halfSectorWidth, _mode);
        false
    } forEach _searchDistancePoints;
    if (_result isNotEqualTo false) exitWith {_result}; false
} forEach _shuffledPlayers;

_result
