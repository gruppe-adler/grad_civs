#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]],
    ["_forcePosition", [], [[]]]
];

private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
private _vehicleSpawnDistanceMin = selectMin _vehicleSpawnDistances;
private _vehicleSpawnDistanceMax = selectMax _vehicleSpawnDistances;

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

// spawn on road side, but *not* on the curb, as we'd have to check for buildings/other obstacles.
private _vehicleWidth= 2; // TODO: get real vehicle width
private _dir = _begPos getDir _endPos;
private _lateralOffset = 0 max (_width/2 - _vehicleWidth);
private _roadSidePos = (getPos _segment) vectorAdd ((vectorNormalized ((getPos _segment) vectorCrossProduct [0, 0, -1])) vectorMultiply _lateralOffset);

[
    _roadSidePos,
    _dir,
    "voyage",
    _house,
    _spawnPositionRoad get "civClasses",
    _spawnPositionRoad get "vehicleClasses"
] call EFUNC(cars,spawnCarAndCrew)
