#include "..\script_component.hpp"

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

private _list = _stateMachine getVariable ["cba_statemachine_list", []];
if !(_listItem in _list) exitWith {
    _default
};

[_listItem, _stateMachine] call CBA_statemachine_fnc_getCurrentState;
