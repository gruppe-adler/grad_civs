private _haveNoVehicle = !(canMove (_this call grad_civs_fnc_getGroupVehicle));

assert(_stateMachine == GRAD_CIVS_STATE_BUSINESS);

private _grpUnits = units _this;
private _nonRallyCount = {
    ([_x, _stateMachine] call CBA_statemachine_fnc_getCurrentState) != "bus_rally"
} count _grpUnits;
private _allRallying = _nonRallyCount == 0;

_allRallying && _haveNoVehicle && ((_this getVariable ["grad_civs_primaryTask", ""]) in ["voyage", "patrol"])
