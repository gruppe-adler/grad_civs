private _idx =  (GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS) find _this;

if (_idx == -1) exitWith {false}; // should not happen, really

if (((floor CBA_missionTime) mod 10) != (_idx mod 10)) exitWith {false}; // only every 10th tick

if (_this getVariable ["grad_civs_excludeFromCleanup",false]) exitWith {false};


private _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEONFOOTMAX * 1.5;
if ((GRAD_CIVS_ONFOOTUNITS find _this) == -1) then {
    _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX * 1.2;
};

private _playersAreClose = true isEqualTo ({
    if (_this distance _x < _cleanupDistance) exitWith { true };
    false
} count ([] call CBA_fnc_players));

!_playersAreClose
