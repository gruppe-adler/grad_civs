#include "..\script_component.hpp"

private _unit = _this;

private _addBehaviour = {
	params ["_unit"];

	_unit setBehaviour "CARELESS";

	_unit disableAI "TARGET";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "FSM";
	_unit disableAI "WEAPONAIM";
	_unit disableAI "AIMINGERROR";
	_unit disableAI "SUPPRESSION";
	_unit disableAI "CHECKVISIBLE";
	_unit disableAI "COVER";
	_unit disableAI "AUTOCOMBAT";
};

_unit setVariable ["BIS_noCoreConversations",true];

_unit addEventHandler [
	"Killed",
    {
		params ["_unit"];
		INFO_2("civ %1 was killed (index: %2), firing internal 'killed' event", _unit, GVAR(localCivs) find _unit);

		["killed", [_unit], [_unit]] call CBA_fnc_targetEvent;

		_unit removeAllEventHandlers "Killed";
		_unit removeAllEventHandlers "FiredNear";
		[QGVAR(switchMove), [_unit, ""]] call CBA_fnc_globalEvent; // TODO: is that really necessary?
    }
];

_unit addEventHandler [
	"FiredNear",
    {
		params ["_unit"];

		// throttle to once every 15s max - which is still a lot
		if ((_unit getVariable [QGVAR(lastFiredNear), 0]) > (CBA_missionTime - 15)) exitWith {};
		_unit setVariable [QGVAR(lastFiredNear), CBA_missionTime];

		LOG_2("gunfight close to %1 at %2", _unit, getPos _unit);
		[QGVAR(firedNear), [_unit], _unit] call CBA_fnc_targetEvent;
    }
];

private _addVars = {
	params [
		["_civ", objNull]
	];
	private _fastSpeed = _civ getSpeed "FAST";
	private _panicCooldown = [GVAR(panicCooldown)] call EFUNC(common,parseCsv);
	_civ setVariable["GRAD_CIVS_PANICCOOLDOWN" , random _panicCooldown, true];
	_civ setVariable["grad_civs_runspeed", random [_fastSpeed * 0.5, _fastSpeed, _fastSpeed * 1.3], true];
	_civ setVariable["grad_civs_recklessness", random [0, 5, 10], true];
};

_unit enableDynamicSimulation true;

_unit setVariable ["asr_ai_exclude", true, true];

[_unit] call _addBehaviour;
[_unit] call _addVars;
