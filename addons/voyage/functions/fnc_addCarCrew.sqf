#include "..\script_component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", []]
];

scopeName "main";

private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
private _vehicleSpawnDistanceMin = _vehicleSpawnDistances#0;
private _vehicleSpawnDistanceMax = _vehicleSpawnDistances#1;

private _pos = if (_forcePosition isEqualTo []) then {
    private _segment = [
        _allPlayers,
        _vehicleSpawnDistanceMin,
        _vehicleSpawnDistanceMax,
        ["voyage"] call EFUNC(lifecycle,getGlobalCivs)
    ] call FUNC(findSpawnRoadSegment);

    if (isNull _segment) then {
        INFO("could not find spawn position for car at this time");
        breakOut "main";
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

[_allPlayers, _pos, 0, "voyage", _house] call EFUNC(cars,spawnCarAndCrew);
