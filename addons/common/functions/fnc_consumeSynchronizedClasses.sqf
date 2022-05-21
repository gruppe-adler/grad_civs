#include "..\script_component.hpp"

/*
Returns [][]string (civClasses, vehicleClasses)
*/

params [
    ["_object", objNull, [objNull]]
];

private _synchronizedObjects = synchronizedObjects _object;

private _civClasses = _object getVariable [QGVAR(civClasses), []];
private _civs = _synchronizedObjects select { _x isKindOf "Man" };
_civClasses = _civClasses + (_civs apply { typeOf _x });
{
    deleteVehicle _x;
} forEach _civs;
_object setVariable [QGVAR(civClasses), _civClasses];

private _vehicleClasses = _object getVariable [QGVAR(vehicleClasses), []];
private _vehicles = _synchronizedObjects select { _x isKindOf "Car" };
_vehicleClasses = _vehicleClasses + (_vehicles apply { typeOf _x });

{
    deleteVehicle _x;
} forEach _vehicles;
_object setVariable [QGVAR(vehicleClasses), _vehicleClasses];

[_civClasses, _vehicleClasses]
