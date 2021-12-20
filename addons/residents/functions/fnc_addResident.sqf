#include "..\script_component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", [0, 0, 0], [[]]]
];

private _house = if (_forcePosition isEqualTo [0, 0, 0]) then {

    private _residentSpawnDistances = [GVAR(spawnDistancesResidents)] call EFUNC(common,parseCsv);
    private _residentSpawnDistanceMin = _residentSpawnDistances#0;
    private _residentSpawnDistanceMax = _residentSpawnDistances#1;

    [
        _allPlayers,
        _residentSpawnDistanceMin,
        _residentSpawnDistanceMax,
        "house"
    ] call EFUNC(lifecycle,findSpawnPosition);
} else {
    ([_forcePosition, 100] call EFUNC(lifecycle,findUnclaimedHouse))
};


if (isNil "_house") exitWith {
    ERROR("could not find spawn position for resident this time (nil)");
    grpNull
};
if (isNull _house) exitWith {
    if (_forcePosition isNotEqualTo [0, 0, 0]) then {
        WARNING_1("could not find spawn position for resident near %1", _forcePosition);
    } else {
        LOG("could not find spawn position for resident this time (null)");
    };
    grpNull
};

[getPos _house, 1, _house, "reside"] call EFUNC(lifecycle,spawnCivilianGroup);
