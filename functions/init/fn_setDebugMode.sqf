#include "..\..\component.hpp"

params [["_value",false]];

missionNamespace setVariable ["GRAD_CIVS_DEBUGMODE",_value,true];
[_value] remoteExec ["GRAD_civs_fnc_showWhatTheyThink",0,false];
