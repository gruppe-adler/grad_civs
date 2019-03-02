#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUGMODE]];

ASSERT_PLAYER("");

GRAD_CIVS_DEBUGMODE = _onOff;
publicVariable "GRAD_CIVS_DEBUGMODE";

[{
	if (!GRAD_CIVS_DEBUGMODE) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};
	_draw = {
		_color = [1,1,1,if (player distance _x < 150) then {0.95} else {0.5}];
		_text = _x getVariable ["grad_civs_infoLine","<no info found. is debug mode enabled where the civs are local?>"];

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color, [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2],
			1, 1, 0, _text, 2, 0.04, "EtelkaNarrowMediumPro", "center", true
		];
	};
	_draw forEach (missionNamespace getVariable ["GRAD_CIVS_ONFOOTUNITS",[]]);
	_draw forEach (missionNamespace getVariable ["GRAD_CIVS_INVEHICLESUNITS",[]]);
} , 0, []] call CBA_fnc_addPerFrameHandler;
