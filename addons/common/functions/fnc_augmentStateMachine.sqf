#include "..\script_component.hpp"

params [
    ["_stateMachineName", "", [""]],
    ["_stateDependencies", [], [[]]], // states names you depend on
    ["_callback", {}, [{}]] // callback, gets the state machine as first param
];

assert((typeName _callback) == "CODE");

//INFO_2("registering state machine augmentation after %1/%2 have been created", _stateMachineName, _stateDependencies);

[
    {
        params [
            ["_stateMachineName", "", [""]],
            ["_stateDependencies", [], [[]]],
            ["_callback", {}, [{}]]
        ];
        private _stateMachine = EGVAR(common,stateMachines) getVariable [_stateMachineName, locationNull];
        if (isNull _stateMachine) exitWith {false};

        private _exists = (_stateDependencies findIf { ! ([_stateMachine, _x] call EFUNC(cba_statemachine,hasState)) }) == -1;
        _exists
    },
    {
        params [
            ["_stateMachineName", "", [""]],
            ["_stateDependencies", [], [[]]],
            ["_callback", {}, [{}]]
        ];
        private _stateMachine = EGVAR(common,stateMachines) getVariable [_stateMachineName, locationNull];
        [_stateMachine] call _callback;
    },
    [_stateMachineName, _stateDependencies, _callback],
    60,
    {
        params [
            ["_stateMachineName", "", [""]],
            ["_stateDependencies", [], [[]]]
        ];
        ERROR_2("state machine %1 did not get initialized or one of %2 states are missing - cannot augment", _stateMachineName, _stateDependencies);
    }
] call CBA_fnc_waitUntilAndExecute;
