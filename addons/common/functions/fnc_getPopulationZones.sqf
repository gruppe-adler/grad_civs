#include "..\script_component.hpp"

params [
	["_pos", [], [[]]]
];

private _createGlobalPopulationZone = {
	private _worldRadius = worldSize / 2;
	createTrigger ["EmptyDetector", _worldRadius, _worldRadius]
};

ISNILS(GVAR(EXCLUSION_ZONES), []);
if ((_pos isNotEqualTo []) && {GVAR(EXCLUSION_ZONES) findIf {_pos inArea (_x)} != -1}) exitWith {[]};

ISNILS(GVAR(POPULATION_ZONES), []);
ISNILS(GVAR(GLOBAL_POPULATION_ZONE), call _createGlobalPopulationZone);

private _applicablePopulationZones = if (count GVAR(POPULATION_ZONES) == 0) then {
	// "there is no population zone" defaults to "*everywhere* is population zone"
	ISNILS(QEGVAR(cars,vehicles), []); // DANGER hacky hack
	[
		"area",
		"civClasses",
		"vehicleClasses"
	] createHashMapFromArray [
		GVAR(GLOBAL_POPULATION_ZONE),
		call EFUNC(lifecycle,config_getCivClasses),
		QEGVAR(cars,vehicles) /*TODO cleanly get vehicle classes in here. how though?*/
	];
} else {
	GVAR(POPULATION_ZONES)
};

if (_pos isEqualTo []) then {
	GVAR(POPULATION_ZONES)
} else {
	_populationZones select {_pos inArea _x}
}
