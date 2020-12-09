#include "..\script_component.hpp"

params [
	["_unit1", objNull, [objNull]],
	["_unit2", objNull, [objNull]],
	["_vehicle", objNull, [objNull]]
];

assert(_unit1 isEqualTo ACE_player);

if (! isNil QGVAR(stolenVehiclePfh)) exitWith {
	INFO_1("switching seats in %1, but already on witness watch", _vehicle);
};

if (!(driver vehicle ACE_player) isEqualTo ACE_player) exitWith {
	INFO_1("seat switched in %1, but not to driver pos: no theft", _vehicle);
};

if ((_unit2 getVariable ["grad_civs_primaryTask", ""]) == "") exitWith { 
	INFO_2("seat switched in %1, but switching partner %2 is no grad-civ: no theft", _vehicle, _unit2);
};

INFO_2("player switched seat to driver position with a grad-civ: likely theft.", _vehicle, _role);
[ACE_player, _vehicle] call FUNC(registerStolen);

// TODO: make sure the civ gets out and continues his life