#include "..\script_component.hpp"

params [
    ["_pos", [], [[]]],
    ["_dir", 0, [0]],
    ["_vehicleClasses", [], [[]]],
    ["_destination", [], [[]]]
];

assert(count _pos > 1);
assert(count _destination > 1);

if (_vehicleClasses isEqualTo []) then {
    _vehicleClasses = GVAR(vehiclesArray);
};
if (_vehicleClasses isEqualTo []) then {
    _vehicleClasses = EGVAR(cars,vehiclesArray);
};
if (_vehicleClasses isEqualTo []) exitWith {
    WARNING_2("will not spawn vehicles as zero vehicle classes are defined for route from %1 to %2", _pos, _destination);
};

private _group = [
    _pos,
    _dir,
    "transit",
    objNull,
    [],
    _vehicleClasses
] call EFUNC(cars,spawnCarAndCrew);

_group setVariable [QGVAR(destination), _destination, true];
