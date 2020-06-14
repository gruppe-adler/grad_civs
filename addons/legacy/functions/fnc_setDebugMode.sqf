#include "..\script_component.hpp"

params [["_value",false]];

if (GVAR(debugCivState) isEqualTo _value) exitWith {};

GVAR(debugCivState) = _value;

[_value] remoteExec [QFUNC(showWhatTheyThink),0,false];
[_value] remoteExec [QFUNC(mapMarkers),0,false];
