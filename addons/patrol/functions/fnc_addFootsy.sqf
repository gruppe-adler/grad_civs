#include "..\script_component.hpp"

params [
    ["_allPlayers", []]
];

private _footSpawnDistances = [[QGVAR(spawnDistancesOnFoot)] call CBA_settings_fnc_get] call EFUNC(common,parseCsv);
private _footSpawnDistanceMin = _footSpawnDistances#0;
private _footSpawnDistanceMax = _footSpawnDistances#1;

private _house = [
    _allPlayers,
    _footSpawnDistanceMin,
    _footSpawnDistanceMax,
    "house"
] call EFUNC(legacy,findSpawnPosition);

if (isNull _house) exitWith {
    LOG("could not find house for patrol");
};

private _maxInitialGroupSize = [QGVAR(initialGroupSize)] call CBA_settings_fnc_get;
private _groupSize = (floor random _maxInitialGroupSize) + 1;

_group = [getPos _house, _groupSize, _house, "patrol"] call EFUNC(legacy,spawnCivilianGroup);
