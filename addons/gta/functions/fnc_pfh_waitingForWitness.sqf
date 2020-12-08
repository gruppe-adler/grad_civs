#include "..\script_component.hpp"

params [
	["_args", [], [[]]],
	["_handle", 0, [0]]
];
_args params [
	["_vehicle", objNull, [objNull]]
];

private _knownThief = _vehicle getVariable ["grad_civs_knownThief", objNull];
if (!isNull _knownThief) exitWith {
	[GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler; GVAR(stolenVehiclePfh) = nil;
	INFO_2("thief of %1 is known to be %2. stopping witness watch", _vehicle, _knownThief);	
};

if ([200, 0.5] call FUNC(isBeingSeen)) exitWith {
	[GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler; GVAR(stolenVehiclePfh) = nil;
	[_vehicle, ACE_player] call FUNC(registerStolen);	
};

if (_vehicle getVariable ["grad_civs_knownStolen", false]) exitWith {};

private _civOwners = units (_vehicle getVariable ["grad_civs_owner", objNull]);
private _parkingPos = _vehicle getVariable ["grad_civs_parkingPos", [0, 0, 0]];
if ([_parkingPos, 0.5, _civOwners] call FUNC(isSpotBeingSeen)) then {
	// do NOT remove framehandler - we dont know the thief yet!
	[_vehicle, objNull] call FUNC(registerStolen);
};
