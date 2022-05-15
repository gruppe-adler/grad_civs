#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]],
    ["_forcePosition", [], [[]]]
];

private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
private _vehicleSpawnDistanceMin = _vehicleSpawnDistances#0;
private _vehicleSpawnDistanceMax = _vehicleSpawnDistances#1;

private _spawnPositionHouse = [
    _allPlayers,
    0,
    _vehicleSpawnDistanceMax * 1.5,
    "house"
] call FUNC(findSpawnPosition);

private _house = if (_spawnPositionHouse isEqualTo false) then {
    objNull
} else {
    _spawnPositionHouse get "house"
};

if (_forcePosition isNotEqualTo []) exitWith {
    [_forcePosition, 0, "voyage", _house] call EFUNC(cars,spawnCarAndCrew);
};

private _spawnPositionRoad = [
    _allPlayers,
    _vehicleSpawnDistanceMin,
    _vehicleSpawnDistanceMax
] call FUNC(findSpawnRoadSegment);

if (_spawnPositionRoad isEqualTo false) exitWith {
    INFO("could not find spawn position for car at this time");
    grpNull
};

private _segment = _spawnPositionRoad get "road";
(getRoadInfo _segment) params ["", "_width", "", "", "", "", "_begPos", "_endPos"];

private _dir = _begPos getDir _endPos;

[
    getPos _segment,
    _dir,
    "voyage",
    _house,
    _spawnPositionRoad get "civClasses",
    _spawnPositionRoad get "vehicleClasses"
] call EFUNC(cars,spawnCarAndCrew)
