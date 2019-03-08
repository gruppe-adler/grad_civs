#include "..\..\component.hpp"


private _unit = _this;


private _reclotheHim = {
	params ["_unit", "_loadout"];

	_unit setUnitLoadout _loadout;

	if (count GRAD_CIVS_FACES > 0) then {
		[_unit, selectRandom GRAD_CIVS_FACES] remoteExec ["setFace",0,_unit];
	};

	_unit setVariable ["BIS_noCoreConversations",true];
};

private _addBeard = {
	params ["_unit"];

	if (count GRAD_CIVS_GOGGLES > 0) then {
		_unit addGoggles selectRandom GRAD_CIVS_GOGGLES;
	};
};

private _addBackpack = {
	params ["_unit"];

	if ((GRAD_CIVS_BACKPACKPROBABILITY > random 100) && {count GRAD_CIVS_BACKPACKS > 0}) then {
		_unit addBackpackGlobal selectRandom GRAD_CIVS_BACKPACKS;
	};
};

private _addBehaviour = {
	params ["_unit"];

	group _unit setBehaviour "CARELESS";
	_unit disableAI "TARGET";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "FSM";
};

private _addKilledNews = {
   (_this select 0) addEventHandler ["Killed",
    {
		params ["_unit"];

		["killed", [_unit], [_unit]] call CBA_fnc_targetEvent;

		_unit removeAllEventHandlers "Killed";
		_unit removeAllEventHandlers "FiredNear";
		_unit switchMove "";
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


		// TODO this seems to reaaally be a frame eater.
		/*
		{
			_distance = _x distance _unit;
			if (_distance < 1000 && _distance > 70) then {
				["fired_far", [_x]] call CBA_fnc_localEvent;
			};
		} forEach (GRAD_CIVS_ONFOOTUNITS - [_unit]);
		*/
    }];
};

private _addVars = {
	params [
		["_civ", objNull]
	];
	_civ setVariable["GRAD_CIVS_PANICCOOLDOWN" , random GRAD_CIVS_PANICCOOLDOWN, true];
	_civ setVariable["grad_civs_runspeed", random [15, 20, 23], true];
	_civ setVariable["grad_civs_recklessness", random [0, 5, 10], true];
};


_unit disableAI "FSM";
_unit setBehaviour "CARELESS";
_unit enableDynamicSimulation true;

[_unit, _vehicle] call GRAD_CIVS_ONSPAWN;



if ((count GRAD_CIVS_CLOTHES > 0) && (count GRAD_CIVS_HEADGEAR > 0)) then {
	private _unitLoadout = [[],[],[],[selectRandom GRAD_CIVS_CLOTHES,[]],[],[],selectRandom GRAD_CIVS_HEADGEAR,"""",[],["""","""","""","""","""",""""]];
	// _stripped = [_unit] call _stripHim;
	[_unit, _unitLoadout] call _reclotheHim;
};

_unit setVariable ["asr_ai_exclude", true];

[_unit] call _addKilledNews;
[_unit] call _addGunfightNewsAndFlee;
[_unit] call _addBehaviour;
[_unit] call _addBeard;
[_unit] call _addBackpack;
[_unit] call _addVars;