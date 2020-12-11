#include "..\script_component.hpp"

#define NESTED(var) (var + "_nested")

params [
    ["_outerStateMachine", locationNull, [locationNull]],
	["_outerState", "", [""]],
    ["_nestedStateMachine", locationNull, [locationNull]]
];

if (!(_nestedStateMachine isEqualType locationNull)) exitWith {ERROR_1("when trying to adding state machine %1: is not CBA state machine!", _nestedStateMachine);};

private _nestedStateMachines = _outerStateMachine getVariable [NESTED(_outerState), false];
if (!(_nestedStateMachines isEqualType [])) exitWith {ERROR_2("state %1 of %2 is not a compound state!", _outerState, _outerStateMachine)};

_nestedStateMachines pushBackUnique _nestedStateMachine;

_outerStateMachine setVariable [NESTED(_outerState), _nestedStateMachines];
