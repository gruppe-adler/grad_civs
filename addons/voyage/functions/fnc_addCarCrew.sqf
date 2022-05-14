#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]],
    ["_forcePosition", [], [[]]]
];

scopeName "main";

private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
private _vehicleSpawnDistanceMin = _vehicleSpawnDistances#0;
private _vehicleSpawnDistanceMax = _vehicleSpawnDistances#1;

private _spawnPositionHouse = [
    _allPlayers,
    0,
    _vehicleSpawnDistanceMax * 1.5,
    "house"
] call FUNC(findSpawnPosition);

private _house = if (isNull _spawnPositionHouse) {
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

if (isNull _spawnPositionRoad) exitWith {
    INFO("could not find spawn position for car at this time");
    grpNull
};

private _segment = _spawnPositionRoad get "road";
[
    getPos _segment,
    0, // TODO get direction from getRoadInfo
    "voyage",
    _house,
    _spawnPositionRoad get "civClasses",
    _spawnPositionRoad get "vehicleClasses"
] call EFUNC(cars,spawnCarAndCrew)
