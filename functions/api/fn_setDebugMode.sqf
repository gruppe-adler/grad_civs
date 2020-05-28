#include "..\..\component.hpp"

params [["_value",false]];

if ((missionNamespace getVariable [QGVAR(DEBUG_CIVSTATE),false]) isEqualTo _value) exitWith {};

missionNamespace setVariable [QGVAR(DEBUG_CIVSTATE),_value,true];

[_value] remoteExec ["grad_civs_fnc_showWhatTheyThink",0,false];
[_value] remoteExec ["grad_civs_fnc_mapMarkers",0,false];
