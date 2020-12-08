#include "..\script_component.hpp"

params ["_unit", "_role", "_vehicle", "_turret"];

private _civOwner = _vehicle getVariable ["grad_civs_owner", objNull];
if (isNull _civOwner) exitWith {
	INFO("getting into car not owned by civs");
};
private _knownThief = _vehicle getVariable ["grad_civs_knownThief", objNull];
if (!isNull _knownThief) exitWith {
	INFO_1("getting into car which is already known as having been stolen by %1.", _knownThief);
};

if (_role != "driver" && (!isNull driver _vehicle )) exitWith {
	INFO_1("getting into car %1 that someone else is driving, no theft.", _vehicle);
};

if (_vehicle getVariable ["grad_civs_parkingPos", []] isEqualTo []) then {
	INFO_1("determining parking pos as %1", getPos _vehicle);
	_vehicle setVariable ["grad_civs_parkingPos", getPos _vehicle, true];
};

INFO("player got into vehicle %1 as %2 and probably committing theft.", _vehicle, _role);
GVAR(stolenVehiclePfh) = [FUNC(pfh_waitingForWitness), 2, [_vehicle]] call CBA_fnc_addPerFrameHandler;