#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUG_CIVSTATE]];

ASSERT_PLAYER("");

GRAD_CIVS_DEBUG_CIVSTATE = _onOff;
publicVariable "GRAD_CIVS_DEBUG_CIVSTATE";

GRAD_CIVS_CIVSTATE_FORMAT = 0;

[{
	if (!GRAD_CIVS_DEBUG_CIVSTATE) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};

	{
	    private _opacity = linearConversion [500, 50, player distance _x, 0.5, 1, true];
	    private _color = [1, 1, 1, _opacity];
		//private _text = _x getVariable ["grad_civs_infoLine","<no info found. is debug mode enabled where the civs are local?>"];
		private _text = "<empty>";
		switch (GRAD_CIVS_CIVSTATE_FORMAT) do {
		    case 0:  { _text =_x getVariable ["grad_civs_infoLine","<no info found. is debug mode enabled where the civs are local?>"]; };
			case 1: { _text = format["%1 | speedmode: %1 %2", _x, speedMode _x, if (leader _x == _x) then {"(is leader)"} else {""}]; };
			case 2: { _text = format["%1 | %2 guns point at him", _x, _x getVariable ["grad_civs_isPointedAtCount", 0]]};
			case 3: { _text = format["%1 | is local at %2", _x, _x getVariable ["grad_civs_owner", 0]]};
		};

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color,
			[(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2],
			1, 1, 0,
			_text, 2, 0.04, "EtelkaNarrowMediumPro", "center", true
		];
	} forEach ([] call GRAD_CIVS_fnc_getGlobalCivs);

	private _poly = player getVariable ["grad_civs_dangerPolyInPlayerHeight", []];
	{
	    private _from = _poly select _forEachIndex;
		private _to = _poly select ((_forEachIndex + 1) mod (count _poly));
		drawLine3D [_from, _to, [1, 0.3, 0.5, 1]];
	} forEach _poly;

} , 0, []] call CBA_fnc_addPerFrameHandler;

 player addAction [
 	"<t color='#3333FF'>switch civstate format</t>",
	{ GRAD_CIVS_CIVSTATE_FORMAT = (GRAD_CIVS_CIVSTATE_FORMAT + 1) % 4; },
	[],
	10,
	false,
	false,
	"",
	"GRAD_CIVS_DEBUG_CIVSTATE"
];
