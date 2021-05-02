#include "..\script_component.hpp"

// returns group
params [
    ["_allPlayers", [], [[]]],
    ["_pos", [], [[]]],
    ["_direction", 0, [0]],
    ["_primaryTask", "", [""]],
    ["_house", objNull, [objNull]],
    ["_vehicleClass", "", [""]]
];

private _vehicleClasses = [];
if (_vehicleClass != "") then {
    _vehicleClasses = [_vehicleClass];
};
if (_vehicleClasses isEqualTo []) then {
    _vehicleClasses = GVAR(vehiclesArray);
};
if (_vehicleClasses isEqualTo []) exitWith {
    WARNING("will not spawn vehicles as zero vehicle classes are defined");
};

_vehicleClass = selectRandom _vehicleClasses;

private _veh = [_pos, _vehicleClass] call FUNC(spawnVehicle);
["ace_common_setDir", [_veh, _dir], _veh] call CBA_fnc_targetEvent;

private _maxInitialGroupSize = EGVAR(patrol,initialGroupSize);
private _automaticVehicleGroupSize = GVAR(automaticVehicleGroupSize);

private _groupSize = (floor random _maxInitialGroupSize) + 1;
if (_automtaicVehicleGroupSize) then {
    private _maxCount = count ((fullCrew [_veh, "", true]) select {
        !(_veh lockedCargo _x#2);
    });
    _groupSize = (floor random [0, 1, _maxCount]) + 1
};

private _group = [_pos, _groupSize, _house, _primaryTask] call EFUNC(lifecycle,spawnCivilianGroup);

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

_group
