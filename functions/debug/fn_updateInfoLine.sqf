#include "..\..\component.hpp"

/*
    set a civ's info line for debugging. this is done server-side, because players cannot access the civ state machine
*/

private _currentEmotion = [_this, GRAD_CIVS_STATE_EMOTIONS] call CBA_statemachine_fnc_getCurrentState;
private _currentActivity = [_this, GRAD_CIVS_STATE_ACTIVITIES] call CBA_statemachine_fnc_getCurrentState;
private _number = count (_this getVariable ["grad_civs_isPointedAtBy",[]]);

ASSERT_SERVER("");

_text = format ["%1 feels %2, %4 guns point at him, and does %3 (%5)", _this, _currentEmotion, _currentActivity, _number, _x call grad_civs_fnc_getCurrentlyThinking];

_this setVariable ["grad_civs_infoLine", _text, true]
