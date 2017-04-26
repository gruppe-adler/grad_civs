/*
 civ unit redressing
*/


#include "..\..\component.hpp"

params ["_unit"];

/*
_stripHim = {
	_it = _this select 0;
	removeAllWeapons _it;
	removeAllItems _it;
	removeAllAssignedItems _it;
	removeUniform _it;
	removeVest _it;
	removeBackpack _it;
	removeHeadgear _it;
	removeGoggles _it;
	_return = true;
	_return
};
*/


//_unitLoadout = [[],[],[],[""LOP_U_AM_Fatigue_01"",[]],[],[],""LOP_H_Pakol"","""",[],["""","""","""","""","""",""""]];

_unitLoadout = [[],[],[],[selectRandom GRAD_CIVS_CLOTHES,[]],[],[],selectRandom GRAD_CIVS_HEADGEAR,"""",[],["""","""","""","""","""",""""]];


_reclotheHim = {
	params ["_guy", "_loadout"];

	_guy setUnitLoadout _loadout;

	if (count GRAD_CIVS_FACES > 0) then {
		[[_guy, selectRandom GRAD_CIVS_FACES], "setCustomFace"] call BIS_fnc_MP;
	};
	_guy setVariable ["BIS_noCoreConversations", true];

};

_addBeard = {
	params ["_guy"];

	if (count GRAD_CIVS_GOGGLES > 0) then {
		_guy addGoggles selectRandom GRAD_CIVS_GOGGLES;
	};
};

_addBackpack = {
	params ["_unit"];

	if (random 100 <= GRAD_CIVS_BACKPACKPROBABILITY && {count GRAD_CIVS_BACKPACKS > 0}) then {
		_unit addBackpackGlobal selectRandom GRAD_CIVS_BACKPACKS;
	};
};



_addBehaviour = {
	group (_this select 0) setBehaviour "CARELESS";
	(_this select 0) disableAI "TARGET";
	(_this select 0) disableAI "AUTOTARGET";
	(_this select 0) disableAI "FSM";
};


_addKilledNews = {
   (_this select 0) addEventhandler ["Killed",
    {
		CIV_KILLED = [(position (_this select 0)), (_this select 0) getVariable ["ace_medical_lastDamageSource", objNull]];
		INFO_1("civ killed: %1",CIV_KILLED);
		publicVariableServer "CIV_KILLED";
		(_this select 0) removeAllEventHandlers "Killed";
		(_this select 0) removeAllEventHandlers "FiredNear";
		(_this select 0) switchMove "";
		GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT - 1;
		GRAD_CIVS_ONFOOTGROUPS = GRAD_CIVS_ONFOOTGROUPS - [(_this select 0)];
    }];
};

_addGunfightNewsAndFlee = {
   (_this select 0) addEventhandler ["FiredNear",
    {
    	CIV_GUNFIGHT_POS = (position (_this select 0));
    	INFO_1("civ gunfight at %1",CIV_GUNFIGHT_POS);
    	publicVariableServer "CIV_GUNFIGHT_POS";

    	if ((_this select 0) getVariable ["GRAD_fleeing",false]) exitWith {};

		_thisUnit = _this select 0;

		_thisUnit enableDynamicSimulation false; // exclude as long as unit is moving

		if (random 2 > 1) then {
			INFO_1("%1 prepares to flee", _thisUnit);
			[_thisUnit] spawn GRAD_civs_fnc_fleeYouFool;
		} else {
			INFO_1("%1 prepares to fake", _thisUnit);
			[_thisUnit] spawn GRAD_civs_fnc_fleeAndFake;
		};
    }];
};

// _stripped = [_unit] call _stripHim;
[_unit, _unitLoadout] call _reclotheHim;

_unit setVariable ["asr_ai_exclude", true];

[_unit] call _addKilledNews;
[_unit] call _addGunfightNewsAndFlee;
[_unit] call _addBehaviour;
[_unit] call _addBeard;
[_unit] call _addBackpack;
