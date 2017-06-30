#include "..\..\component.hpp"

params ["_playerPositions"];

private _position = [
	_playerPositions,
	GRAD_CIVS_SPAWNDISTANCEMIN,
	GRAD_CIVS_SPAWNDISTANCEMAX,
	GRAD_CIVS_ONFOOTUNITS
] call grad_civs_fnc_findSpawnSegment;

if (_position isEqualTo [0,0,0]) exitWith {};

INFO_1("Position: %1", _position);

private _group = createGroup [civilian, true];
private _unit = _group createUnit ["C_man_1", _position, [], 0, "NONE"];

_unit disableAI "FSM";
_unit setBehaviour "CARELESS";

[_unit] call grad_civs_fnc_dressAndBehave;
_unit enableDynamicSimulation true;

[_unit, _position, 400 - (random 300), [3,6], [0,2,10]] call grad_civs_fnc_taskPatrol;

if (GRAD_CIVS_DEBUGMODE || (!isNil "DEBUG_MODE" && {DEBUG_MODE})) then {
	[_position] call grad_civs_fnc_createDebugMarker;
};

GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT + 1;
GRAD_CIVS_ONFOOTUNITS = GRAD_CIVS_ONFOOTUNITS + [_unit];

INFO_1("added civilian on foot, now %1", GRAD_CIVS_ONFOOTCOUNT);

[_unit] call GRAD_CIVS_ONSPAWN;
