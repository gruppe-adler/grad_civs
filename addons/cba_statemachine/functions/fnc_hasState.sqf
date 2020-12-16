#include "..\script_component.hpp"

params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_state", "", [""]]
];

assert(!(isNull _stateMachine));

private _states = _stateMachine getVariable ["cba_statemachine_states", []];

_state in _states
