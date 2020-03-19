//    1: position     position or object - if object, position of object is used
//    2: radius       number or array - if array, random radius between first and second element is used
//    3: count        number > 1, or array - amount of waypoints to generate, if array, random amount between first and second element is used

#include "..\..\component.hpp"

params [
    ["_position", [0, 0, 0]],
    ["_radius", 0],
    ["_count", 3],
    ["_findPosOfInterest",false],
    ["_findRoadPos",false],
    ["_findWaterPos",false]
];

private _waypointPositions = [];

for [{_i=0}, {_i<_count}, {_i=_i+1}] do {

    private _nextWaypoint = [
        _position,
        _radius,
        20,
        _findPosOfInterest,
        _findRoadPos,
        _findWaterPos
    ] call FUNC(taskPatrolFindWaypoint);

    if (_nextWaypoint isEqualTo []) exitWith {
        WARNING_3("could not find more than %1 waypoints within %2m around %3", _i, _radius, _position)
    };
    LOG_1("waypoint #%1 found", _i);
    _waypointPositions pushBack _nextWaypoint;
};

_waypointPositions
