#include "..\script_component.hpp"

params [
	["_player", objNull, [objNull]],
	["_unit2", objNull, [objNull]],
	["_vehicle", objNull, [objNull]]
];

if (isNull _unit2) exitWith {
	TRACE_1("switching seat in %1 with nobody, it seems", _vehicle);
};

if (! isNil QGVAR(stolenVehiclePfh)) exitWith {
	TRACE_1("switching seats in %1, but already on witness watch", _vehicle);
};

if ((driver vehicle _player) != _player) exitWith {
	TRACE_1("seat switched in %1, but not to driver pos: no theft", _vehicle);
};

if ((_unit2 getVariable ["grad_civs_primaryTask", ""]) == "") exitWith { 
	TRACE_2("seat switched in %1, but switching partner %2 is no grad-civ: no theft", _vehicle, _unit2);
};

INFO_2("player switched seat to driver position with a grad-civ: likely theft.", _vehicle, _role);
[_player, _vehicle] call FUNC(registerStolen);

// TODO: make sure the civ gets out and continues his life
