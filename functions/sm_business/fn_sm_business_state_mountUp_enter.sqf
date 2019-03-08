_veh = _this call grad_civs_fnc_getGroupVehicle;
if (canMove _veh) then {
    _this assignAsDriver _veh;
    [_this] orderGetIn true;
} else {
    [_this, nil] call grad_civs_fnc_setGroupVehicle;
};
