#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]],
    ["_forcePosition", [0, 0, 0], [[]]]
];

scopeName "main";

private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
private _vehicleSpawnDistanceMin = _vehicleSpawnDistances#0;
private _vehicleSpawnDistanceMax = _vehicleSpawnDistances#1;

private _pos = if (_forcePosition isEqualTo [0, 0, 0]) then {
    private _segment = [
        _allPlayers,
        _vehicleSpawnDistanceMin,
        _vehicleSpawnDistanceMax
    ] call FUNC(findSpawnRoadSegment);

    if (isNull _segment) then {
        INFO("could not find spawn position for car at this time");
        grpNull breakOut "main";
    };
    getPos _segment
} else {
    _forcePosition
};

private _house = [
    _allPlayers,
    0,
    _vehicleSpawnDistanceMax * 1.5,
    "house"
] call FUNC(findSpawnPosition);

[_pos, 0, "voyage", _house] call EFUNC(cars,spawnCarAndCrew);
