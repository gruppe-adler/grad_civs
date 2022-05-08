#include "..\script_component.hpp"

//    1: position     position or object - if object, position of object is used
//    2: radius       number or array - if array, random radius between first and second element is used
//    3: count        number > 1, or array - amount of waypoints to generate, if array, random amount between first and second element is used

params [
    ["_position", [0, 0, 0]],
    ["_radius", 0],
    ["_maxTries", 10],
    ["_findPosOfInterest",false],
    ["_findRoadPos",false],
    ["_findWaterPos",false]
];

private _waypointPosition = [];

//create waypoints

for "_i" from 1 to _maxTries do {
    LOG_1("trying to create wp - pass #%1 ", _i);

    private _searchPosition = [
        _position,
        [_radius / 2 ,_radius],
        [0,360],
        nil,
        _findWaterPos,
        _findRoadPos
    ] call EFUNC(lifecycle,findRandomPos);
    if (_searchPosition isEqualTo []) then {
        _searchPosition = _position;
    };

    _searchPosition = if (_findPosOfInterest && {80 > random 100}) then {
        [_searchPosition, false] call EFUNC(lifecycle,findPositionOfInterest);
    } else {
        _searchPosition
    };

    private _popZones = [_searchPosition] call EFUNC(common,getPopulationZones);
    if (count _popZones > 0) exitWith {
        LOG_1("position %1 is not in exclusionzone, return it", _searchPosition);
        _waypointPosition = _searchPosition;
    };
    LOG_1("not creating WP at %1", _searchPosition);
};

_waypointPosition
