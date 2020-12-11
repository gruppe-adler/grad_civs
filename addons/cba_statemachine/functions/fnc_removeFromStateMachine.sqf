#include "..\script_component.hpp"

params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull]
];

private _thisTarget = "";
private _onTransition = {};
private _thisTransition = "MANUAL";
private _thisOrigin = [_listItem, _stateMachine] call FUNC(getCurrentState);
private _thisState = _thisOrigin;
if (_thisOrigin == "") exitWith {
    LOG_2("hmmm, %1 is not currently in any state of machine %2", _listItem, _stateMachine getVariable "#var");
};
LOG_2("removing %1 from machine %2", _listItem, _stateMachine getVariable "#var");

// in a perfect world, I'd call a manual transition to "" , buuut that function does not recognize emtpy targets.
_listItem call (_stateMachine getVariable ONSTATELEAVING(_thisOrigin));

private _list = _stateMachine getVariable ["cba_statemachine_list", []];
_list deleteAt (_list find _listItem);

private _id = _stateMachine getVariable "cba_statemachine_ID";
_listItem setVariable ["cba_statemachine_state" + str _id, nil];
