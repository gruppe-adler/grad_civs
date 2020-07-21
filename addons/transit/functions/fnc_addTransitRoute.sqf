#include "..\script_component.hpp"

params [
    ["_source", [0, 0, 0], [[]]],
    ["_sourceDir", 0, [0]],
    ["_sinks", [], [[]]],
    ["_interval", 60, [0]],
    ["_vehicleClasses", [], [[]]]
];

assert(isServer);

scopeName "main";

if (_vehicleClasses isEqualTo []) then {
    _vehicleClasses = [GVAR(vehicles)] call EFUNC(common,parseCsv);
};
if (_vehicleClasses isEqualTo []) then {
    _vehicleClasses = [EGVAR(cars,vehicles)] call EFUNC(common,parseCsv);
};
if (_vehicleClasses isEqualTo []) then {
    WARNING_1("will not spawn vehicles in transit source %1 as no vehicle classes are defined anywhere");
    breakOut "main";
};

assert(_interval > 0);
assert(!(_source isEqualTo [0, 0, 0]));

if (count _sinks == 0) exitWith {
    ERROR_1("transit route source %1 without sinks is bad mkay", _source);
};

ISNILS(GVAR(transitRoutes), []);

private _newRoute = true call CBA_fnc_createNamespace;
_newRoute setVariable ["source", _source, true];
_newRoute setVariable ["sourceDir", _sourceDir, true];
_newRoute setVariable ["sinks", _sinks, true];
_newRoute setVariable ["interval", _interval, true];
_newRoute setVariable ["vehicles", _vehicleClasses, true];
_newRoute setVariable ["lastSpawn", -999999, true];

GVAR(transitRoutes) pushBack _newRoute;
publicVariable QGVAR(transitRoutes);
