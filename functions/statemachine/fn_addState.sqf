#include "..\..\component.hpp"

#define TIMEDONSTATEENTERED(var) (var + "_onTimedStateEntered")
#define TIMEDONSTATELEAVING(var) (var + "_onTimedStateLeaving")
#define TIMEDONSTATE(var) (var + "_onTimedState")
#define STATEMACHINEIDVAR(var) (var getVariable "CBA_statemachine_ID")
#define TIMEVAR(var) format["grad_civs_state_time_%1", var]

params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_onState", {}, [{}]],
    ["_onStateEntered", {}, [{}]],
    ["_onStateLeaving", {}, [{}]],
    ["_name", "", [""]]
];

private _wrappedOnStateEntered = {
    private _entering = if (isNil "_thisTarget") then {_thisState} else {_thisTarget};
    private _origOnStateEntered = _stateMachine getVariable [TIMEDONSTATEENTERED(_entering), {}];
    private _thisStateTime = CBA_missionTime;
    _this setVariable [TIMEVAR(STATEMACHINEIDVAR(_stateMachine)), _thisStateTime];
    _this call _origOnStateEntered;
};

private _wrappedOnStateLeaving = {
    private _origOnStateLeaving = _stateMachine getVariable [TIMEDONSTATELEAVING(_thisState), {}];
    _thisStateTime = _this getVariable [TIMEVAR(STATEMACHINEIDVAR(_stateMachine)), 0];
    _this call _origOnStateLeaving;
};

private _wrappedOnState = {
    private _origOnState = _stateMachine getVariable [TIMEDONSTATE(_thisState), {}];
    _thisStateTime = _this getVariable [TIMEVAR(STATEMACHINEIDVAR(_stateMachine)), 0];
    _this call _origOnState;
};

private _state = [_stateMachine, _onState, _wrappedOnStateEntered, _wrappedOnStateLeaving, _name] call CBA_statemachine_fnc_addState;

if (_state == "") exitWith {ERROR_1("could not add state", _name); ""};

_stateMachine setVariable [TIMEDONSTATEENTERED(_state), _onStateEntered];
_stateMachine setVariable [TIMEDONSTATELEAVING(_state), _onStateLeaving];
_stateMachine setVariable [TIMEDONSTATE(_state), _onState];

_state
