#include "..\script_component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", [], [[]]]
];

private _house = if (_forcePosition isEqualTo []) then {

    private _residentSpawnDistances = [GVAR(spawnDistancesResidents)] call EFUNC(common,parseCsv);
    private _residentSpawnDistanceMin = selectMin _residentSpawnDistances;
    private _residentSpawnDistanceMax = selectMax _residentSpawnDistances;

    private _spawnPosition = [
        _allPlayers,
        _residentSpawnDistanceMin,
        _residentSpawnDistanceMax,
        "house"
    ] call EFUNC(lifecycle,findSpawnPosition);
    if (_spawnPosition isEqualTo false) then {
        objNull
    } else {
        _spawnPosition get "house"
    }
} else {
    ([_forcePosition, 100, true] call EFUNC(lifecycle,findUnclaimedHouse))
};


if (isNull _house) exitWith {
    if (_forcePosition isNotEqualTo []) then {
        WARNING_1("could not find spawn position for resident near %1", _forcePosition);
    } else {
        LOG("could not find spawn position for resident this time (null)");
    };
    grpNull
};

[getPos _house, 1, _house, "reside"] call EFUNC(lifecycle,spawnCivilianGroup);
