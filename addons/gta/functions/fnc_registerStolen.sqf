#include "..\script_component.hpp"

params [
	["_vehicle", objNull, [objNull]], 
	["_thief", objNull, [objNull]]
];

INFO_2("broadcasting thief of %1 to be %2", _vehicle, _thief);
_vehicle setVariable ["grad_civs_knownThief", _thief, true];
_vehicle setVariable ["grad_civs_knownStolen", true, true];
["grad_civs_vehicleTheft", [_vehicle, _thief]] call CBA_fnc_globalEvent;
