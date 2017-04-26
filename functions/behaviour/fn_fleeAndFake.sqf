#include "..\..\component.hpp"

_thisUnit = _this select 0;
_group = group _thisUnit;

if (vehicle _thisUnit != _thisUnit && random 2 > 0.5) then {
	dostop _thisUnit;
	sleep 1;
	_group leaveVehicle (vehicle _thisUnit);
};

INFO_1("civ %1 is faking a human", _thisUnit);
_thisUnit setVariable ["GRAD_civs_currentlyThinking", "who the fuck is shooting, have to run far away"];

_pos = [position _thisUnit] call GRAD_civs_fnc_findPositionOfInterest;

_pos = [_thisUnit,[50,1000],[0,360]] call grad_civs_fnc_findRandomPos;
_thisUnit doMove _pos;
_thisUnit setSpeedMode "FULL";
_thisUnit forceSpeed 20;
_thisUnit playMove "SprintCivilBaseDf";
_thisUnit setVariable ["GRAD_fleeing", true];

INFO_2("civ %1 is fake fleeing to %2", _thisUnit, _pos);

sleep 60;

units _group doFollow leader _group;
[_group, _pos, 400 - (random 300), [3,6], [0,2,10]] call GRAD_civs_fnc_taskPatrol;
_thisUnit setVariable ["GRAD_civs_currentlyThinking", "task patrol assigned"];
_thisUnit setVariable ["GRAD_fleeing", false];
_thisUnit enableDynamicSimulation true;
