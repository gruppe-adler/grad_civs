#include "..\..\component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", []]
];

private _pos = if (_forcePosition isEqualTo []) then {
    private _segment = [
        _allPlayers,
        GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN,
        GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX,
        ["voyage"] call FUNC(getGlobalCivs)
    ] call FUNC(findSpawnRoadSegment);
    LOGTIME_END("findSpawnPos_vehicle");

    if (isNull _segment) exitWith {
        LOG("could not find spawn position for car at this time");
    };
    LOGTIME_START("findSpawnPos_vehicle");
    getPos _segment
} else {
    _forcePosition
};


private _house = [
    _allPlayers,
    0,
    GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX * 1.5,
    "house"
] call FUNC(findSpawnPosition);


private _vehicleClass = selectRandom GRAD_CIVS_VEHICLES;

_veh = [_pos, _vehicleClass] call grad_civs_fnc_spawnVehicle;

private _groupSize = floor random GRAD_CIVS_INITIALGROUPSIZE;
if (GRAD_CIVS_AUTOMATICVEHICLEGROUPSIZE) then {
    private _maxCount = count ((fullCrew [_veh, "", true]) select {
        !(_veh lockedCargo _x#2);
    });
    _groupSize = (floor random [0, 1, _maxCount]) + 1
};

_group = [_pos, _groupSize, _veh, _house, "voyage"] call grad_civs_fnc_spawnCivilianGroup;
