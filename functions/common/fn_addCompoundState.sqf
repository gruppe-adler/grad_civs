#include "..\..\component.hpp"

#define ONSTATEENTERED(var) (var + "_onStateEntered")
#define ONSTATELEAVING(var) (var + "_onStateLeaving")

#define NESTED(var) (var + "_nested")
#define ORIGINALONSTATEENTERED(var) (var + "_onOriginalStateEntered")
#define ORIGINALONSTATELEAVING(var) (var + "_onOriginalStateLeaving")

params [
    ["_outerStateMachine", locationNull, [locationNull]],
    ["_nestedStateMachines", [], [locationNull, []]],
    ["_onState", {}, [{}]],
    ["_onStateEntered", {}, [{}]],
    ["_onStateLeaving", {}, [{}]],
    ["_name", "", [""]]
];

if (!(_nestedStateMachines isEqualType [])) then { _nestedStateMachines = [_nestedStateMachines]; };
if (!(_nestedStateMachines isEqualTypeAll locationNull)) exitWith {ERROR("not all _nestedStateMachines are CBA state machines!"); ""};
{
    if (!((_x getVariable ["CBA_statemachine_list", []]) isEqualType [])) exitWith {ERROR("nested state machines must have empty items array!"); ""};
} forEach _nestedStateMachines;

_compoundOnStateEntered = {
    private _origOnStateEntered = _stateMachine getVariable [ORIGINALONSTATEENTERED(_thisTarget), {}];  /*in onEnter. _thisState is the previous state -.-*/
    private _nestedStateMachines = _stateMachine getVariable [NESTED(_thisTarget), []];

    _this call _origOnStateEntered;

    {
        private _nestedList = _x getVariable ["CBA_statemachine_list", []];
        _nestedList pushBackUnique _this;
    } forEach _nestedStateMachines;
};

_compoundOnStateLeaving = {
    private _origOnStateLeaving = _stateMachine getVariable [ORIGINALONSTATELEAVING(_thisTarget), {}];  /*in onEnter. _thisState is the previous state -.-*/
    private _nestedStateMachines = _stateMachine getVariable [NESTED(_thisState), []];

    {
        private _nestedList = _x getVariable ["CBA_statemachine_list", []];
        _nestedList deleteAt (_nestedList find _this);
    } forEach _nestedStateMachines;

    _this call _origOnStateLeaving;
};


private _state = [_outerStateMachine, _onState, _compoundOnStateEntered, _compoundOnStateLeaving, _name] call CBA_statemachine_fnc_addState;

if (_state == "") exitWith {ERROR_1("could not add state", _name); ""};

_outerStateMachine setVariable [NESTED(_state), _nestedStateMachines];
_outerStateMachine setVariable [ORIGINALONSTATEENTERED(_state), _onStateEntered];
_outerStateMachine setVariable [ORIGINALONSTATELEAVING(_state), _onStateLeaving];

_state
