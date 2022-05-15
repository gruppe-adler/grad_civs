#include "..\script_component.hpp"

ISNILS(GVAR(transitRoutes), []);

private _spawnableRoutes = GVAR(transitRoutes) select {
    CBA_missionTime > (_x getVariable ["lastSpawn", 0]) + (_x getVariable ["interval", 300]);
};

if (_spawnableRoutes isEqualTo []) exitWith {};

private _route = selectRandom _spawnableRoutes;

_route setVariable ["lastSpawn", CBA_missionTime, true];

private _source = _route getVariable ["source", [0, 0, 0]];
private _sourceDir = _route getVariable ["sourceDir", 0];
private _sinks = _route getVariable ["sinks", []];
private _civClasses = _route getVariable ["civClasses", []];
private _vehicleClasses = _route getVariable ["vehicleClasses", []];
if (_sinks isEqualTo []) exitWith {
    ERROR_2("no sinks for transit route %1 starting at %2", _route. _source);
};

[_source, _sourceDir, _civClasses, _vehicleClasses, selectRandom _sinks] call FUNC(addTransitVehicle);
