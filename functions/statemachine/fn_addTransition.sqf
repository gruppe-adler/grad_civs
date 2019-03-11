#include "..\..\component.hpp"

#define TIMEDTRANSITIONCONDITION(var) (var + "_onTimedTransitionCondition")
#define TIMEDTRANSITIONHANDLER(var) (var + "_onTimedTransitionHandler")
#define STATEMACHINEIDVAR(var) (var getVariable "CBA_statemachine_ID")
#define TIMEVAR(var) format["grad_civs_state_time_%1", var]

params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_originalState", "", [""]],
    ["_targetState", "", [""]],
    ["_condition", {}, [{}]],
    ["_onTransition", {}, [{}]],
    ["_name", "", [""]]
];

if (_name isEqualTo "") exitWith {false}; // NEED a name here!

private _wrappedCondition = {
    private _origCondition = _stateMachine getVariable [TIMEDTRANSITIONCONDITION(_thisTransition), {}];
    private _thisStateTime = _this getVariable [TIMEVAR(STATEMACHINEIDVAR(_stateMachine)), 0];
    _this call _origCondition;
};

private _wrappedHandler = {
    private _origHandler = _stateMachine getVariable [TIMEDTRANSITIONHANDLER(_thisTransition), {}];
    private _thisStateTime = _this getVariable [TIMEVAR(STATEMACHINEIDVAR(_stateMachine)), 0];
    _this call _origHandler;
};

private _result = [
    _stateMachine,
    _originalState, _targetState,
    _wrappedCondition,
    _wrappedHandler,
    _name
] call CBA_statemachine_fnc_addTransition;

if (!_result) exitWith {_result};

_stateMachine setVariable [TIMEDTRANSITIONCONDITION(_name), _condition];
_stateMachine setVariable [TIMEDTRANSITIONHANDLER(_name), _onTransition];

_result
