#include "..\script_component.hpp"

params [
    ["_allPlayers", []],
    ["_forcePosition", []]
];

scopeName "main";

private _vehicleSpawnDistances = parseSimpleArray ([QGVAR(spawnDistancesInVehicles)] call CBA_settings_fnc_get);
private _vehicleSpawnDistanceMin = _vehicleSpawnDistances#0;
private _vehicleSpawnDistanceMax = _vehicleSpawnDistances#1;

private _pos = if (_forcePosition isEqualTo []) then {
    private _segment = [
        _allPlayers,
        _vehicleSpawnDistanceMin,
        _vehicleSpawnDistanceMax,
        ["voyage"] call EFUNC(legacy,getGlobalCivs)
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

private _vehicleClasses = parseSimpleArray ([QGVAR(vehicles)] call CBA_settings_fnc_get);
if (_vehicleClasses isEqualTo []) exitWith {
    WARNING("will not spawn vehicles as zero vehicle classes are defined");
};
private _vehicleClass = selectRandom _vehicleClasses;

_veh = [_pos, _vehicleClass] call FUNC(spawnVehicle);

private _maxInitialGroupSize = [QEGVAR(patrol,initialGroupSize)] call CBA_settings_fnc_get;
private _automaticVehicleGroupSize = [QGVAR(automaticVehicleGroupSize)] call CBA_settings_fnc_get;

private _groupSize = (floor random _maxInitialGroupSize) + 1;
if (_automtaicVehicleGroupSize) then {
    private _maxCount = count ((fullCrew [_veh, "", true]) select {
        !(_veh lockedCargo _x#2);
    });
    _groupSize = (floor random [0, 1, _maxCount]) + 1
};

_group = [_pos, _groupSize, _house, "voyage"] call EFUNC(legacy,spawnCivilianGroup);

{
    // for convenience & speed: shortcut so units dont have to lengthily embark on their own
    // also, prevents issues with civs spawning inside their vehicle,
    //   which for some reason happens to lone drivers regardless of "NONE" collision flag on spawn
    if (_x == leader _group) then {
        _x moveInDriver _veh;
        _x assignAsDriver _veh;
    } else {
        _x moveInCargo _veh;
        _x assignAsCargo _veh;
    };
} forEach (units _group);

[_group, _veh] call FUNC(setGroupVehicle);
