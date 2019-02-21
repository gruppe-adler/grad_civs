private _delay = (_this getVariable ["grad_civs_act_leave_state_time", 0]) - CBA_missionTime;
[_this, format ["will leave this ordered state in  %1s", _delay]] call grad_civs_fnc_setCurrentlyThinking;
