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
    ["_callback", {}, [{}]] /*code that will be called with [ ["_err", "", [""]], ["_path", [], [[]]] ] */
];

private _timeout = 10;

assert(_vehicleType in ["man", "car", "tank", "wheeled_APC", "boat", "plane", "helicopter"]);

_flags params [
    ["_isOnRoad", false, [true]],
    ["_isInHouse", false, [true]],
    ["_isOnWater", false, [true]]
];

// find a position
private _targetPos = [
    _startPoint,
    _distance,
    _direction,
    ["B_Soldier_F", "C_Van_01_fuel_F"] select _isOnRoad,
    _isOnWater,
    _isOnRoad
] call EFUNC(common,findRandomPos);

if (_targetPos isEqualTo []) exitWith {
    LOG("could not find position in target area");
    ["could not find position in target area", objNull] call _callback;
};
LOG_1("target pos: %1", _targetPos);


ISNILS(GVAR(lastPathId), 0);
INC(GVAR(lastPathId));
private _pathId = GVAR(lastPathId);

private _agent = calculatePath [_vehicleType, "safe", _startPoint, _targetPos];
_agent setVariable [QGVAR(pathId), _pathId];
_agent addEventHandler [
    "PathCalculated",
    {
		params ["_agent", "_path"];
        if (count _path == 2) exitWith {
            LOG("PathCalculated useless callback with target only");
        };
        LOG_2("path calculated for id %1 with %2 elements", _agent getVariable [QGVAR(pathId), -1], count _path);
        [
            QGVAR(path_calculated),
            [
                grpNull,
                _agent getVariable [QGVAR(pathId), -1],
                _path
            ]
        ] call CBA_fnc_localEvent; // TODO document diagnostics!
        _agent setVariable [QGVAR(createdPath), _path];
    }
]);

// wait for N seconds

[
    {
        params ["_agent"];
        (_agent getVariable [QGVAR(createdPath), false]) isEqualType []
    },
    {
        params ["_agent", "_callback"];
        deleteVehicle _agent;
        ["", _agent getVariable [QGVAR(createdPath), []]] call _callback;
    },
    [_agent, _callback],
    _timeout,
    {
        params ["_agent", "_callback"];
        deleteVehicle _agent;
        WARNING_1("pathing takes too long, deleting %1", _agent);
        deleteVehicle _agent;
        ["pathing timeout!", []] call _callback;

    }
] call CBA_fnc_waitUntilAndExecute;
