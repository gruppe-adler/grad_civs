params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull]
];

private _list = _stateMachine getVariable ["cba_statemachine_list", []];
_list deleteAt (_list find _listItem);

private _id = _stateMachine getVariable "cba_statemachine_ID";
_listItem setVariable ["cba_statemachine_state" + str _id, nil];
