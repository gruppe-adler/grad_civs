#include "..\script_component.hpp"
// NOTE: on Eject, assignedVehicleRole may still return "driver"
#define IS_DRIVER (assignedDriver vehicle ACE_player == ACE_player)

// to be called whenever vehicle status changes

LOG_1("vehicleSeatHandler %1", ACE_player);

ISNILS(GVAR(roadDefaultActionEH), -1);
ISNILS(GVAR(airPfh), -1);

if IS_DRIVER then {
	LOG_1("is driver! checking vehicle %1", vehicle ACE_player);
	if ((vehicle ACE_player) isKindOf "Car") then {
		LOG_1("adding roadDefaultActionEH for %1", vehicle ACE_player);
		if (GVAR(roadDefaultActionEH) != -1) exitWith {
			WARNING("roadDefaultActionEH already set");
		};
		GVAR(roadDefaultActionEH) = addUserActionEventHandler ["DefaultAction", "Activate", {
			if (!IS_DRIVER) exitWith {
				WARNING("this is not supposed to happen");
				[] call FUNC(vehicleSeatHandler);
			};
			[] call FUNC(checkHonkingOnCivilian);
		}];
	};
	if ((vehicle ACE_player) isKindOf "Air") then {
		LOG_1("adding airPfh for %1", vehicle ACE_player);
		if (GVAR(airPfh) != -1) exitWith {
			WARNING("airPfh already set");
		};
		GVAR(airPfh) = [FUNC(checkFlyScaringCivilian), 0.5] call CBA_fnc_addPerFrameHandler;
	};
} else {
	LOG("is not driver!");
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
};
