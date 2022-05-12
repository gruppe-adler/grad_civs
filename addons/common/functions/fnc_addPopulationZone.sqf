#include "..\script_component.hpp"

params [
	["_area", objNull, [objNull, ""]],
	["_civClasses", [], [[]]],
	["_vehicleClasses", [], [[]]]
];

ISNILS(GVAR(POPULATION_ZONES), []);
GVAR(POPULATION_ZONES) pushBack ([POPULATION_ZONE_KEY_AREA, POPULATION_ZONE_KEY_CIVCLASSES, POPULATION_ZONE_KEY_VEHICLECLASSES] createHashMapFromArray [_area, _civClasses, _vehicleClasses]);

INFO_3("added population zone %1 with civs: (%2) and vehicles (%3) ", _area, _civClasses, _vehicleClasses);
