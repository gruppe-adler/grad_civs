#include "..\script_component.hpp"

params [
	["_civ", objNull, [objNull]]
];

{
	deleteVehicle _x;
} forEach ((attachedObjects _civ) select { _x isKindOf "Sign_Arrow_Large_Pink_F"});
