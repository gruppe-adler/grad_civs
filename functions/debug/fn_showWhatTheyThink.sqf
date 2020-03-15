#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUG_CIVSTATE]];

ASSERT_PLAYER("");

GRAD_CIVS_DEBUG_CIVSTATE = _onOff;
publicVariable "GRAD_CIVS_DEBUG_CIVSTATE";

GRAD_CIVS_CIVSTATE_FORMAT = 0;

[{
	if (!GRAD_CIVS_DEBUG_CIVSTATE) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};

	if (!isGameFocused || isGamePaused) exitWith {};

	_filterTimeVars = {
		(allVariables _this) select {
			(_x find "grad_civs_state_time_") > -1
		} apply {
			[_x, floor CBA_missionTime - (_this getVariable _x)] joinString ": "
		} joinString ", ";
	};

	{
	    private _opacity = linearConversion [500, 50, player distance _x, 0.5, 1, true];
	    private _color = [1, 1, 1, _opacity];
		private _text = "<empty>";
		switch (GRAD_CIVS_CIVSTATE_FORMAT) do {
		    case 0:  { _text =_x getVariable ["grad_civs_infoLine","<no info found. is debug mode enabled where the civs are local?>"]; };
			case 1: { _text = format["%1 | speedmode: %2 %3", _x, speedMode _x, if (leader _x == _x) then {"(is leader)"} else {""}]; };
			case 2: { _text = format["%1 | %2 guns point at him", _x, _x getVariable ["grad_civs_isPointedAtCount", 0]]};
			case 3: { _text = format["%1 | is local at %2", _x, _x getVariable ["grad_civs_owner", 0]]};
			case 4: { _text = format["%1 | %2 %3 %4 | stopped: %5, unitReady: %6", _x, behaviour _x, combatMode _x, speedMode _x, stopped _x, unitReady _x]};
			case 5: { _text = format["%1 | state times: %2", _x, _x call _filterTimeVars]};
			default { _text = ""};
		};

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color,
			[(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2],
			1, 1, 0,
			_text, 2, 0.03, "EtelkaNarrowMediumPro", "center", true
		];
	} forEach ([] call GRAD_CIVS_fnc_getGlobalCivs);

	private _poly = player getVariable ["grad_civs_dangerPolyInPlayerHeight", []];
	{
	    private _from = _poly select _forEachIndex;
		private _to = _poly select ((_forEachIndex + 1) mod (count _poly));
		drawLine3D [_from, _to, [1, 0.3, 0.5, 1]];
	} forEach _poly;

} , 0, []] call CBA_fnc_addPerFrameHandler;

private _addCivAction = {
	params [
		["_title", ""],
		["_id", 0]
	];

	player addAction [
	 	_title,
		{ GVAR(CIVSTATE_FORMAT) = _this#3; },
		_id,
		10,
		false,
		false,
		"",
		"GRAD_CIVS_DEBUG_CIVSTATE"
	];
};

["<t color='#3333FF'>civstate format: infoLine</t>", 0] call _addCivAction;
["<t color='#3333FF'>civstate format: speedmode</t>", 1] call _addCivAction;
["<t color='#3333FF'>civstate format: guns</t>", 2] call _addCivAction;
["<t color='#3333FF'>civstate format: locality</t>", 3] call _addCivAction;
["<t color='#3333FF'>civstate format: behaviour</t>", 4] call _addCivAction;
["<t color='#3333FF'>civstate format: state times</t>", 5] call _addCivAction;
["<t color='#3333FF'>civstate format: waypoints</t>", 6] call _addCivAction;
["<t color='#3333FF'>civstate format: empty</t>", 7] call _addCivAction;


ISNILS(GVAR(showWhatTheyThink_civ_added), 0);
ISNILS(GVAR(showWhatTheyThinkciv_removed), 0);
if (GRAD_CIVS_DEBUG_CIVSTATE) then {
	GVAR(showWhatTheyThink_civ_added) = [
		QGVAR(civ_added),
		{
			SCRIPT("showWhatTheyThink_civ_added");
			{
				private _arrow = createSimpleObject ["Sign_Arrow_Large_Pink_F", [0, 0, 0]];
				_arrow attachTo [_x, [0, 0, 5]];
			} forEach _this;
		}
	] call CBA_fnc_addEventHandler;
	GVAR(showWhatTheyThinkciv_removed) = [
		QGVAR(civ_removed),
		{
			SCRIPT("showWhatTheyThink_civ_removed");
			{
				private _civ = _x;
				{
					deleteVehicle _x;
				} forEach (attachedObjects _civ);
			} forEach _this;
		}
	] call CBA_fnc_addEventHandler;
} else {
	[QGVAR(civ_added), GVAR(showWhatTheyThink_civ_added)] call CBA_fnc_removeEventHandler;
	[QGVAR(civ_removed), GVAR(showWhatTheyThinkciv_removed)] call CBA_fnc_removeEventHandler;
};
