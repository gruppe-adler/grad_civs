#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUGMODE]];

GRAD_CIVS_DEBUGMODE = _onOff;

[{
	if (!GRAD_CIVS_DEBUGMODE) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};

	_color = [1,1,1,0.9];
	{

		_text = _x getVariable ["GRAD_civs_currentlyThinking", "no special purpose"];

		_number = count (_x getVariable ["GRAD_civs_isPointedAtBy",[]]);

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color, [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2],
			1, 1, 0, _text + " | code | " + str _number, 1, 0.02, "EtelkaNarrowMediumPro", "center", true
		];

	} forEach allUnits - allPlayers;
} , 0, []] call CBA_fnc_addPerFrameHandler;
