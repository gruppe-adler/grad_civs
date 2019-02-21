if (_this == leader _this) then {
    _grp = group _this;
    (units _grp) doFollow (leader _this);
    [_this, _this, 400 - (random 300), [3,6], [0,2,10]] call grad_civs_fnc_taskPatrol;

    {
        _x setSpeedMode "LIMITED";
        _x forceSpeed -1;
        _x stop false; // should not be necessary
        _x playMoveNow "AmovPercMstpSnonWnonDnon";
        _x enableDynamicSimulation true;
        false
    } count (units _grp);
};
