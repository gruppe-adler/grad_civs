#include "..\script_component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_maxDistance", 0, [0]],
	["_visibility", 0.5, [0]]
];

private _civClasses = call EFUNC(lifecycle,config_getCivClasses);

-1 != ((player nearEntities [_civClasses, _maxDistance]) findIf {([vehicle _unit, "VIEW"] checkVisibility [eyePos _x, getPosASL _unit]) > _visibility})