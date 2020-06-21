#include "..\script_component.hpp"

ASSERT_SERVER("");

/*
    set a civ's info line for debugging. this is done server-side, because players cannot access the civ state machine
*/

private _statemachineNames = allVariables EGVAR(common,stateMachines);
private _states = (_statemachineNames apply {
    private _sm = EGVAR(common,stateMachines) getVariable _x;
    private _state = [_this, _sm, "NONE"] call EFUNC(cba_statemachine,getCurrentState);

    format ["%1: %2", _x, _state];
}) joinString ", ";

private _text = format ["%1 | %2 | %3", _this, _states, _this call FUNC(getCurrentlyThinking)];

_this setVariable ["grad_civs_infoLine", _text, true];
_this setVariable ["grad_civs_owner", clientOwner, true];
