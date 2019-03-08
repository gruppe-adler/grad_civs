if (_this getVariable ["grad_civs_act_leave_state_time", 0] < CBA_missionTime) then {
    private _recklessness = _this getVariable ["grad_civs_recklessness", 5];
    private _waitTime = linearConversion [0, 10, _recklessness, 180, 15, false];

    _this setVariable ["grad_civs_act_leave_state_time", CBA_missionTime + _waitTime];
};
