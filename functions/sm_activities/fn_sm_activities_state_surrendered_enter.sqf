[_this] call GRAD_CIVS_ONHELDUP;
_this setVariable ["grad_civs_surrenderTime", CBA_missionTime];
[_this, true] call ACE_captives_fnc_setSurrendered;
_this disableAI "MOVE";
_this disableAI "ANIM";
