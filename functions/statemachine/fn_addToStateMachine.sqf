
params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull]
];

private _list = _stateMachine getVariable ["cba_statemachine_list", []];
_list pushBackUnique _listItem;
