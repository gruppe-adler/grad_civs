#include "..\script_component.hpp"
// NOTE: on Eject, assignedVehicleRole may still return "driver"
#define IS_DRIVER (call FUNC(playerIsDriver))

// to be called whenever vehicle status changes

ISNILS(GVAR(roadDefaultActionEH), -1);
ISNILS(GVAR(airPfh), -1);

if (GVAR(roadDefaultActionEH) != -1) exitWith {
	LOG_1("removing EH %1", GVAR(roadDefaultActionEH));
	removeUserActionEventHandler ["DefaultAction",  "Activate", GVAR(roadDefaultActionEH)];
	GVAR(defaultActionEH) = -1;
};
if (GVAR(airPfh) != -1) then {
	LOG_1("removing pfh %1", GVAR(airPfh));
	[GVAR(airPfh)] call CBA_fnc_removePerFrameHandler;
	GVAR(airPfh) = -1;
};

private _playerVehicle = vehicle (call CBA_fnc_currentUnit);

LOG_1("vehicleSeatHandler %1", (call CBA_fnc_currentUnit));

if IS_DRIVER then {
	LOG_1("is driver! checking vehicle %1", _playerVehicle);
	if (_playerVehicle isKindOf "Car") then {
		LOG_1("adding roadDefaultActionEH for %1", _playerVehicle);
		if (GVAR(roadDefaultActionEH) != -1) exitWith {
			WARNING("roadDefaultActionEH already set");
		};
		GVAR(roadDefaultActionEH) = addUserActionEventHandler ["DefaultAction", "Activate", {
			if (!IS_DRIVER) exitWith {
				WARNING("DefaultAction EH called while not being driver. this is not supposed to happen. removing EH...");
				[] call FUNC(vehicleSeatHandler);
			};
			private _vic = vehicle (call CBA_fnc_currentUnit);
			if (!(_vic isKindOf "Car")) exitWith {
				WARNING_1("wtf %1 is not a car", _vic);
				[] call FUNC(vehicleSeatHandler);
			};
			[] call FUNC(checkHonkingOnCivilian);
		}];
	};
	if (_playerVehicle isKindOf "Air") then {
		LOG_1("adding airPfh for %1", _playerVehicle);
		if (GVAR(airPfh) != -1) exitWith {
			WARNING("airPfh already set");
		};
		GVAR(airPfh) = [{
			if (!IS_DRIVER) exitWith {
				WARNING("DefaultAction EH called while not being driver. this is not supposed to happen. removing EH...");
				[] call FUNC(vehicleSeatHandler);
			};
			private _vic = vehicle (call CBA_fnc_currentUnit);
			if (!(_vic isKindOf "Air")) exitWith {
				// FIXME this will trigger when player dies! fix!
				// also after ejecting
				WARNING_1("wtf %1 is not an air vic", _vic);
				[] call FUNC(vehicleSeatHandler);
			};

			[_vic] call FUNC(checkFlyScaringCivilian);
		}, 0.5] call CBA_fnc_addPerFrameHandler;
	};
} else {
	LOG("is not driver!");
};
