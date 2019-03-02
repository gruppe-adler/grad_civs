private _haveNoVehicle = !(canMove (_this call grad_civs_fnc_getGroupVehicle));

private _grpUnits = units _this;
private _nonRallyCount = {
    ([_x, GRAD_CIVS_STATE_ACTIVITIES] call CBA_statemachine_fnc_getCurrentState) != "act_rally"
} count _grpUnits;
private _allRallying = _nonRallyCount == 0;

_allRallying && _haveNoVehicle
