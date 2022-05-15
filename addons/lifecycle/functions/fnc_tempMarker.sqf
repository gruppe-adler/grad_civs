#include "..\script_component.hpp"

params [
	["_position", [], [[]]],
	["_text", "", [""]],
	["_timeout", 2, [0]]
];

ISNILS(GVAR(markerId), 0);
GVAR(markerId) = GVAR(markerId) + 1;
private _markerName = format ["debugmarker%1", GVAR(markerId)];

private _m = createMarkerLocal [_markerName, _position];
_m setMarkerTextLocal _text;
_m setMarkerTypeLocal "hd_dot";

[
	{
		params ["_m"];
		deleteMarkerLocal _m;
	},
	[_m],
	_timeout
] call CBA_fnc_waitAndExecute;

_m
