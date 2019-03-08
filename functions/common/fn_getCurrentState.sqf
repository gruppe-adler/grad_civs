#include "..\..\component.hpp"

/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_getCurrentState
Description:
    Get current state
Parameters:
    _listItem       - item to get the state of <any namespace type>
    _stateMachine   - state machine <LOCATION>
    _default        - return if item not subject to state machine <string>, defaults to ""
Returns:
    _currentState   - state of the given item or _default <STRING>
Examples:
    (begin example)
        _currentState = [player, _stateMachine, ""] call CBA_statemachine_fnc_getCurrentState;
    (end)
Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */

params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull, [locationNull]],
    ["_default", ""]
];

private _id = _stateMachine getVariable "cba_statemachine_ID";
[_listItem getVariable ("cba_statemachine_state" + str _id)] param [0, _default];
