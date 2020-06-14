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

private _addKilledNews = {
   (_this select 0) addEventHandler ["Killed",
    {
		params ["_unit"];

		["killed", [_unit], [_unit]] call CBA_fnc_targetEvent;

		_unit removeAllEventHandlers "Killed";
		_unit removeAllEventHandlers "FiredNear";
		[QGVAR(switchMove), [_unit, ""]] call CBA_fnc_globalEvent;
    }];
};

private _addGunfightNewsAndFlee = {
   (_this select 0) addEventHandler ["FiredNear",
    {
		params ["_unit"];

    	CIV_GUNFIGHT_POS = getPos _unit;
    	INFO_1("civ gunfight at %1",CIV_GUNFIGHT_POS);
    	publicVariableServer "CIV_GUNFIGHT_POS";
		["fired_near", [_unit], [_unit]] call CBA_fnc_targetEvent;
    }];
};

private _addVars = {
	params [
		["_civ", objNull]
	];
	private _fastSpeed = _civ getSpeed "FAST";
	private _panicCooldown = parseSimpleArray ([QGVAR(panicCooldown)] call cba_settings_fnc_get); // TODO safe parsing
	_civ setVariable["GRAD_CIVS_PANICCOOLDOWN" , random _panicCooldown, true];
	_civ setVariable["grad_civs_runspeed", random [_fastSpeed * 0.5, _fastSpeed, _fastSpeed * 1.3], true];
	_civ setVariable["grad_civs_recklessness", random [0, 5, 10], true];
};

_unit enableDynamicSimulation true;

ISNILS(GRAD_CIVS_ONSPAWN, {}); // TODO trigger event instead
[_unit] call GRAD_CIVS_ONSPAWN;


_unit setVariable ["asr_ai_exclude", true];

[_unit] call _addKilledNews;
[_unit] call _addGunfightNewsAndFlee;
[_unit] call _addBehaviour;
[_unit] call _addVars;
