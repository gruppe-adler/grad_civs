private _leader = leader _this;
if (([_leader, GRAD_CIVS_STATE_ACTIVITIES] call CBA_statemachine_fnc_getCurrentState) == "act_mountUp") then {
    private _veh = vehicle _leader;
    if (_veh != _leader) then {
        _this assignAsCargo _veh;
        [_this] orderGetIn true;
    };
} else {
    if ((_leader == vehicle _leader) && (_this != vehicle _this)) then {
        unassignVehicle _this;
    };
};
