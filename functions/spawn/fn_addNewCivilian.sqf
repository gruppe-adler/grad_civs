#include "..\..\component.hpp"

params ["_playerPositions"];

[_playerPositions] spawn {
	params ["_playerPositions"];

	_position = [
		_playerPositions,
		GRAD_CIVS_SPAWNDISTANCEMIN,
		GRAD_CIVS_SPAWNDISTANCEMAX,
		GRAD_CIVS_ONFOOTGROUPS
	] call GRAD_civs_fnc_findSpawnSegment;

	if (_position isEqualTo [0,0,0]) exitWith {};

	INFO_1("Position: %1", _position);

	_group = createGroup [civilian, true]; // todo: adapt to 1.67 [civilian, true]
	_unit = _group createUnit ["C_man_1", _position, [], 0, "NONE"];


	// _unit disableAI "MOVE";
	_unit disableAI "FSM";
	_unit setBehaviour "CARELESS";

	[_unit] call GRAD_civs_fnc_dressAndBehave;
	_unit enableDynamicSimulation true;

	[_unit, _position, 400 - (random 300), [3,6], [0,2,10]] call GRAD_civs_fnc_taskPatrol;

	if (GRAD_CIVS_DEBUGMODE || (!isNil "DEBUG_MODE" && {DEBUG_MODE})) then {
		[_position] call GRAD_civs_fnc_createDebugMarker;
	};

	GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT + 1;
	GRAD_CIVS_ONFOOTGROUPS = GRAD_CIVS_ONFOOTGROUPS + [_unit];

	INFO_1("added civilian on foot, now %1", GRAD_CIVS_ONFOOTCOUNT);

	[_unit] call GRAD_CIVS_ONSPAWN;
};
