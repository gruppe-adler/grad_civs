#include "..\..\component.hpp"

params [
    ["_allPlayers", []]
];

LOGTIME_START("findSpawnPos_vehicle");
_pos = [
    _allPlayers,
    GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN,
    GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX,
    GRAD_CIVS_INVEHICLESUNITS
] call grad_civs_fnc_findSpawnPosition;
LOGTIME_END("findSpawnPos_vehicle");

if (_pos isEqualTo [0,0,0]) exitWith {};

private _groupSize = random GRAD_CIVS_INITIALGROUPSIZE;

LOGTIME_START("spawnCiv_vehicle");
_veh = [_pos, (selectRandom GRAD_CIVS_VEHICLES)] call grad_civs_fnc_spawnVehicle;
_group = [_pos, _groupSize, _veh] call grad_civs_fnc_spawnCivilianGroup;

LOGTIME_END("spawnCiv_vehicle");

GRAD_CIVS_INVEHICLESUNITS = GRAD_CIVS_INVEHICLESUNITS + (units _group);
if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_INVEHICLESUNITS";};
