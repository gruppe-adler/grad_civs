#include "..\script_component.hpp"

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

    LOG_4("%1 is entering %2 / %3. adding to nested machines %4", _this, _stateMachine getVariable "#var", _entering, _nestedStateMachines apply {_x getVariable "#var"});
    _this call _origOnStateEntered;
    {
        [_this, _x] call FUNC(addToStateMachine);
    } forEach _nestedStateMachines;
};

private _wrappedOnStateLeaving = {

    private _origOnStateLeaving = _stateMachine getVariable [COMPOUNDONSTATELEAVING(_thisState), {}];
    private _nestedStateMachines = _stateMachine getVariable [NESTED(_thisState), []];

    LOG_4("%1 is leaving %2 / %3. removing from nested machines %4", _this, _stateMachine getVariable "#var", _thisState, _nestedStateMachines apply {_x getVariable "#var"});
    {
        [_this, _x] call FUNC(removeFromStateMachine);
    } forEach _nestedStateMachines;

    _this call _origOnStateLeaving;
};

private _state = [_outerStateMachine, _onState, _wrappedOnStateEntered, _wrappedOnStateLeaving, _name] call FUNC(addState);

if (_state == "") exitWith {ERROR_1("could not add compound state '%1'", _name); ""};

_outerStateMachine setVariable [NESTED(_state), _nestedStateMachines];
_outerStateMachine setVariable [COMPOUNDONSTATEENTERED(_state), _onStateEntered];
_outerStateMachine setVariable [COMPOUNDONSTATELEAVING(_state), _onStateLeaving];

_state
