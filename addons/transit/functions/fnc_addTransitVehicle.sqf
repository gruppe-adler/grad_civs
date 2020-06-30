#include "..\script_component.hpp"

params [
    ["_pos", [], [[]]],
    ["_dir", 0, [0]],
    ["_destination", [], [[]]]
];

assert(count _pos > 1);
assert(count _destination > 1);

scopeName "main";

private _vehicleClasses = parseSimpleArray ([QGVAR(vehicles)] call CBA_settings_fnc_get);
if (_vehicleClasses isEqualTo []) exitWith {
    WARNING("will not spawn vehicles as zero vehicle classes are defined");
};
private _vehicleClass = selectRandom _vehicleClasses;

private _group = [
    [],
    _pos,
    _dir,
    "transit",
    objNull,
    _vehicleClass
] call EFUNC(cars,spawnCarAndCrew);

_group setVariable [QGVAR(destination), _destination, true];
