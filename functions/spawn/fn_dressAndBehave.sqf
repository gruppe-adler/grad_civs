/*
 civ unit redressing
*/


#include "..\..\component.hpp"

params ["_unit"];


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
   (_this select 0) addEventhandler ["Killed",
    {
		params ["_unit"];

		CIV_KILLED = [(position _unit), _unit getVariable ["ace_medical_lastDamageSource", objNull]];
		INFO_1("civ killed: %1",CIV_KILLED);
		publicVariableServer "CIV_KILLED";
		_unit removeAllEventHandlers "Killed";
		_unit removeAllEventHandlers "FiredNear";
		_unit switchMove "";

		GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT - 1;
		GRAD_CIVS_ONFOOTUNITS = GRAD_CIVS_ONFOOTUNITS - [(_this select 0)];
		if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_ONFOOTUNITS"};
    }];
};

private _addGunfightNewsAndFlee = {
   (_this select 0) addEventhandler ["FiredNear",
    {
		params ["_unit"];

    	CIV_GUNFIGHT_POS = getPos _unit;
    	INFO_1("civ gunfight at %1",CIV_GUNFIGHT_POS);
    	publicVariableServer "CIV_GUNFIGHT_POS";

		(group _unit) setVariable ["grad_civs_lastGunshotHeard",CBA_missionTime];

		[_unit] call grad_civs_fnc_flee;
    }];
};


private _unitLoadout = [[],[],[],[selectRandom GRAD_CIVS_CLOTHES,[]],[],[],selectRandom GRAD_CIVS_HEADGEAR,"""",[],["""","""","""","""","""",""""]];
// _stripped = [_unit] call _stripHim;
[_unit, _unitLoadout] call _reclotheHim;

_unit setVariable ["asr_ai_exclude", true];

[_unit] call _addKilledNews;
[_unit] call _addGunfightNewsAndFlee;
[_unit] call _addBehaviour;
[_unit] call _addBeard;
[_unit] call _addBackpack;
