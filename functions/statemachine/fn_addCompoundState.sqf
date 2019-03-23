#include "..\..\component.hpp"

#define NESTED(var) (var + "_nested")
#define COMPOUNDONSTATEENTERED(var) (var + "_onCompoundStateEntered")
#define COMPOUNDONSTATELEAVING(var) (var + "_onCompoundStateLeaving")

params [
    ["_outerStateMachine", locationNull, [locationNull]],
    ["_nestedStateMachines", [], [locationNull, []]],
    ["_onState", {}, [{}]],
    ["_onStateEntered", {}, [{}]],
    ["_onStateLeaving", {}, [{}]],
    ["_name", "", [""]]
];

if (!(_nestedStateMachines isEqualType [])) then { _nestedStateMachines = [_nestedStateMachines]; };
if (!(_nestedStateMachines isEqualTypeAll locationNull)) exitWith {ERROR_2("when trying to create state %1: not all _nestedStateMachines %2 are CBA state machines!", _name, _nestedStateMachines); ""};
{
    if (!((_x getVariable ["cba_statemachine_list", []]) isEqualType [])) exitWith {ERROR("nested state machines must have empty items array!"); ""};
} forEach _nestedStateMachines;

private _wrappedOnStateEntered = {
    // workaround BUG caused by clockwork: depending on whether we're in the initial state, _thisTarget may not be set
    private _entering = if (isNil "_thisTarget") then {_thisState} else {_thisTarget};
    private _origOnStateEntered = _stateMachine getVariable [COMPOUNDONSTATEENTERED(_entering), {}];  /*in onEnter. _thisState is the previous state -.-*/
    private _nestedStateMachines = _stateMachine getVariable [NESTED(_entering), []];

    _this call _origOnStateEntered;
    {
        [_this, _x] call grad_civs_fnc_addToStateMachine;
    } forEach _nestedStateMachines;
};

private _wrappedOnStateLeaving = {

    private _origOnStateLeaving = _stateMachine getVariable [COMPOUNDONSTATELEAVING(_thisTarget), {}];
    private _nestedStateMachines = _stateMachine getVariable [NESTED(_thisState), []];

    {
        [_this, _x] call grad_civs_fnc_removeFromStateMachine;
    } forEach _nestedStateMachines;

    _this call _origOnStateLeaving;
};

private _state = [_outerStateMachine, _onState, _wrappedOnStateEntered, _wrappedOnStateLeaving, _name] call grad_civs_fnc_addState;

if (_state == "") exitWith {ERROR_1("could not add state", _name); ""};

_outerStateMachine setVariable [NESTED(_state), _nestedStateMachines];
_outerStateMachine setVariable [COMPOUNDONSTATEENTERED(_state), _onStateEntered];
_outerStateMachine setVariable [COMPOUNDONSTATELEAVING(_state), _onStateLeaving];

_state
