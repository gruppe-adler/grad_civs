private _leader = leader _this;

assert(_stateMachine == GRAD_CIVS_STATE_BUSINESS);

/*if leader is calling for mounting up: get in*/
if (([_leader, _stateMachine] call CBA_statemachine_fnc_getCurrentState) == "bus_mountUp") then {
    private _veh = vehicle _leader;
    if (_veh != _leader) then {
        _this assignAsCargo _veh;
        [_this] orderGetIn true;
    };
} else {
    /*if leader is unmounted, and I'm not: get out*/
    if ((_leader == vehicle _leader) && (_this != vehicle _this)) then {
        unassignVehicle _this;
    };
};
