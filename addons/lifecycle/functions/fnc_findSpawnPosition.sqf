#include "..\script_component.hpp"

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
private _shuffledPlayers = _allPlayers call BIS_fnc_arrayShuffle;
private _result = {
    // try to find houses - and abort when we found one thats good
    private _refPlayer = _x;
    private _result = {
        private _refPos = (getPos _refPlayer) vectorAdd _x;
        LOG_3("looking for spawn pos around %1 which is pos#%2 derived from player %3 ", _refPos, _forEachIndex, _refPlayer);

        // [QGVAR(spawnRefpos), [_refPos]] call CBA_fnc_localEvent;
        #ifdef DEBUG_MODE_FULL
            private _r = [_refPos, format["spawn_refpos_%1", _forEachIndex], 1.5] call FUNC(tempMarker);
            _r setMarkerTypeLocal "hd_unknown";
        #endif

        private _candidate = switch (_mode) do {
            case "road": {
                // for each position, get a road position close by
                private _road = selectRandom (_refPos nearRoads _halfSectorWidth);
                if (count (_road nearEntities ["Man", 100]) == 0) then {
                    _road
                } else {
                    false
                }
            };
            case "house": {
                ([_refPos, _halfSectorWidth, false] call FUNC(findUnclaimedHouse))
            };
            default {
                WARNING_1("invalid mode '%1' provided to findSpawnPosition", _mode);
                false
            };
        };

        // [QGVAR(spawnCandidate), [_refPos, _candidate]] call CBA_fnc_localEvent;
        #ifdef DEBUG_MODE_FULL
            private _c = "";
            if (isNull _candidate) then {
                _r setMarkerColorLocal "ColorRed";
            } else {
                _r setMarkerColorLocal "ColorGrey";
                _c = [getPos _candidate, format["spawn_candidate_%1", _forEachIndex]] call FUNC(tempMarker);
                _c setMarkerTypeLocal "hd_start";
            };
        #endif

        LOG_1("_candidate (before vetting): %1", _candidate);
        private _popZones = [];
        if ((!(isNull _candidate))
            && {
                LOG_3("_allPlayers: %1, _candidate %2, _minDistance %3", _allPlayers, getPos _candidate, _minDistance);
                private _minDistanceIsGiven = [_allPlayers, _candidate, _minDistance] call FUNC(isInDistanceFromOtherPlayers);

                // [QGVAR(spawnCandidateMinDistance), [_refPos, _candidate]] call CBA_fnc_localEvent;
                #ifdef DEBUG_MODE_FULL
                if (_minDistanceIsGiven) then {
                    _c setMarkerColorLocal "ColorYellow";
                } else {
                    _c setMarkerColorLocal "ColorRed";
                };
                #endif

                _minDistanceIsGiven
            }
        ) then {
            _popZones = [getPos _candidate] call EFUNC(common,getPopulationZones);
        };
        if (count _popZones > 0) exitWith {

            // [QGVAR(spawnCandidatePopzone), [_refPos, _candidate]] call CBA_fnc_localEvent;
            #ifdef DEBUG_MODE_FULL
                _c setMarkerColorLocal "ColorGreen";
            #endif

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
