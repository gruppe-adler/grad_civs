#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUGMODE]];

if (!hasInterface) exitWith {};

GRAD_CIVS_DEBUGMODE = _onOff;

[{
	if (!GRAD_CIVS_DEBUGMODE) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};
	_draw = {
		_color = [1,1,1,if (player distance _x < 200) then {0.9} else {0.5}];
		_text = _x getVariable ["grad_civs_currentlyThinking", "no special purpose"];

		_number = count (_x getVariable ["grad_civs_isPointedAtBy",[]]);

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color, [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2],
			1, 1, 0, _text + " | code | " + str _number, 1, 0.02, "EtelkaNarrowMediumPro", "center", true
		];
	};
	_draw forEach (missionNamespace getVariable ["GRAD_CIVS_ONFOOTUNITS",[]]);
	_draw forEach (missionNamespace getVariable ["GRAD_CIVS_INVEHICLESUNITS",[]]);
} , 0, []] call CBA_fnc_addPerFrameHandler;
