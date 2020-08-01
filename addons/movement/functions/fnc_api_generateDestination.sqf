#include "..\script_component.hpp"

/*
 * high level function to generate pathed waypoint for a group.
 * lots of options to pass here, unfortunately - will still try to keep param count low
 */

/**
 * returns array of [_path, _destination] with _destination being a position or object at a position
 */

params [
    ["_startPoint", [0, 0, 0], [[]]],
    ["_flags", [], [[]], 3], /*various options*/
    ["_distance", [0, 0], [[]], 2], /*min,max*/
    ["_direction", [0, 360], [[]], 2], /*from,to*/
    ["_vehicleType", "", [""]],
    ["_callbackAndParams", [{}, []], [[]], 2] /*array: 0) code that will be called with [ ["_err", "", [""]], ["_path", [], [[]]], ["_args", [], []] ] ; 1) arguments*/
];

private _timeout = 30;

assert(_vehicleType in ["man", "car", "tank", "wheeled_APC", "boat", "plane", "helicopter"]);

_flags params [
    ["_isOnRoad", false, [true]],
    ["_isInHouse", false, [true]],
    ["_isOnWater", false, [true]]
];

_callbackAndParams params [
    ["_callback", {}, [{}]],
    ["_callbackArgs", [], []]
];

// find a position
private _targetPos = [
    _startPoint,
    _distance,
    _direction,
    nil,
    _isOnWater,
    _isOnRoad
] call EFUNC(legacy,findRandomPos);

if (_targetPos isEqualTo []) exitWith {
    LOG_4("could not find position in target area (from: %1 ; dist: %2 ; dir %3 ; onRoad: %4)", _startPoint, _distance, _direction, _isOnRoad);
    ["could not find position in target area", objNull, _callbackArgs] call _callback;
};
LOG_1("target pos: %1", _targetPos);

[_startPoint, _targetPos, _vehicleType, _callbackAndParams] call FUNC(generatePath);
true