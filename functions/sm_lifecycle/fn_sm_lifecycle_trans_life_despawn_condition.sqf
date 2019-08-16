private _idx =  GRAD_CIVS_LOCAL_CIVS find _this;

if (_idx == -1) exitWith {false}; // should not happen, really

if (((floor CBA_missionTime) mod 10) != (_idx mod 10)) exitWith {false}; // check only every 10s for a given unit

if (_this getVariable ["grad_civs_excludeFromCleanup",false]) exitWith {false};

private _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX * 1.2;
if (isNull (_this call grad_civs_fnc_getGroupVehicle)) then {
    _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEONFOOTMAX * 1.5;
};
if (_this distance nearestBuilding _this < 3) then {
    _cleanupDistance = GRAD_CIVS_SPAWNDISTANCERESIDENTMAX * 1.2;
};

private _playersAreClose = true isEqualTo ({
    if (_this distance _x < _cleanupDistance) exitWith { true };
    false
} count (allPlayers - (entities "HeadlessClient_F")));
// CBA_fnc_players would work, if you dont mind things despawning close to zeus

!_playersAreClose
