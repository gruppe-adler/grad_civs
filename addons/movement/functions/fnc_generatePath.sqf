#include "..\script_component.hpp"

params [
    ["_startPoint", [0, 0, 0], [[]], [2,3]],
    ["_destination", [0, 0, 0], [[]], [2,3]],
    ["_vehicleType", "", [""]],
    ["_callbackAndParams", [{}, []], [[]], 2] /*array: 0) code that will be called with [ ["_err", "", [""]], ["_path", [], [[]]], ["_args", [], []] ] ; 1) arguments*/
];
_callbackAndParams params [
    ["_callback", {}, [{}]],
    ["_callbackArgs", [], []]
];

ISNILS(GVAR(lastPathId), 0);
INC(GVAR(lastPathId));
private _pathId = GVAR(lastPathId);

private _agent = calculatePath [_vehicleType, "safe", _startPoint, _destination];
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
            QGVAR(pathCalculated),
            [
                grpNull,
                _agent getVariable [QGVAR(pathId), -1],
                _path
            ]
        ] call CBA_fnc_localEvent; // TODO document diagnostics!
        _agent setVariable [QGVAR(createdPath), _path];
    }
];

[
    {
        params ["_agent"];
        isNull _agent || {(_agent getVariable [QGVAR(createdPath), false]) isEqualType []}
    },
    {
        params ["_agent", "_callback", "_callbackArgs"];

        if (isNull _agent) exitWith {
            ["agent became null", [], _callbackArgs] call _callback;
            WARNING_1("pathing failed - agent became null", _agent);
        };
        deleteVehicle _agent;
        ["", _agent getVariable [QGVAR(createdPath), []], _callbackArgs] call _callback;
    },
    [_agent, _callback, _callbackArgs],
    _timeout,
    {
        params ["_agent", "_callback", "_callbackArgs"];
        WARNING_1("pathing takes too long - deleting %1", _agent);
        deleteVehicle _agent;
        ["pathing timeout!", [], _callbackArgs] call _callback;

    }
] call CBA_fnc_waitUntilAndExecute;

true