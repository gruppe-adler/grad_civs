#include "..\script_component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", [], [[]]]
];

scopeName "main";

private _maxInitialGroupSize = GVAR(initialGroupSize);
private _groupSize = (floor random _maxInitialGroupSize) + 1;

private _footSpawnDistances = [GVAR(spawnDistancesOnFoot)] call EFUNC(common,parseCsv);
private _footSpawnDistanceMin = _footSpawnDistances#0;
private _footSpawnDistanceMax = _footSpawnDistances#1;

private _spawnPosition = objNull;

if (_forcePosition isEqualTo []) then {
    _spawnPosition = [
        _allPlayers,
        _footSpawnDistanceMin,
        _footSpawnDistanceMax,
        "house"
    ] call EFUNC(lifecycle,findSpawnPosition);

    if (isNull _spawnPosition) exitWith {
        LOG("could not find house for patrol");
        grpNull breakOut "main";
    };

    #ifdef DEBUG_MODE_FULL
        assert(!isNull(_spawnPosition get "house"));
        assert(!isNull(_spawnPosition get "civClasses"));
    #endif

    [getPos (_spawnPosition get "house"), _groupSize, _spawnPosition get "house", "patrol", _spawnPosition get "civClasses"] call EFUNC(lifecycle,spawnCivilianGroup);
} else {
    [_forcePosition, _groupSize, objNull, "patrol", []] call EFUNC(lifecycle,spawnCivilianGroup);
};
