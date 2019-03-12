#include "..\..\component.hpp"

ASSERT_SERVER("");

/*
    set a civ's info line for debugging. this is done server-side, because players cannot access the civ state machine
*/

private _statemachineNames = allVariables GRAD_CIVS_STATEMACHINES;
private _states = (_statemachineNames apply {
    private _sm = GRAD_CIVS_STATEMACHINES getVariable _x;
    private _state = [_this, _sm, "NONE"] call grad_civs_fnc_getCurrentState;

    format ["%1: %2", _x, _state];
}) joinString ", ";

_text = format ["%1 | %2 | %3", _this, _states, _x call grad_civs_fnc_getCurrentlyThinking];

_this setVariable ["grad_civs_infoLine", _text, true];
_this setVariable ["grad_civs_owner", clientOwner, true];
