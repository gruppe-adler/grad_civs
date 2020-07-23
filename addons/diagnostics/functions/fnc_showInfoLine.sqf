#include "..\script_component.hpp"

ISNILS(GVAR(civStateFormat), 0);
ISNILS(GVAR(actionIds), []);

[{
	params [
		["_args", [], [[]]],
		["_handle", 0, [0]]
	];
	if (!(GVAR(showInfoLine))) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

	if (!isGameFocused || isGamePaused) exitWith {};

	_filterTimeVars = {
		((allVariables _this) select {
			(_x find "grad_civs_state_time_") > -1
		} apply {
			[_x, floor CBA_missionTime - (_this getVariable _x)] joinString ": "
		}) joinString ", ";
	};

	private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
	private _camDir = getCameraViewDirection ACE_player;

	{
		private _opacity = linearConversion [500, 50, _camPos distance _x, 0.2, 1, true];
		private _text = "o";

		private _diff = (getPosASL _x) vectorDiff _camPos;
		private _civAngle = acos (_camDir vectorCos _diff);

		private _fov = deg getObjectFOV ACE_player;

		if (_civAngle < _fov) then {

			_text = "<empty>";
			switch (GVAR(civStateFormat)) do {
			    case 0:  { _text =_x getVariable ["grad_civs_infoLine","<no info found. is debug mode enabled where the civs are local?>"]; };
				case 1: { _text = format["%1 | speedmode: %2 %3", _x, speedMode _x, if (leader _x == _x) then {"(is leader)"} else {""}]; };
				case 2: { _text = format["%1 | %2 guns point at him", _x, _x getVariable ["grad_civs_isPointedAtCount", 0]]};
				case 3: { _text = format["%1 | is local at %2", _x, _x getVariable ["grad_civs_local_at", 0]]};
				case 4: { _text = format["%1 | %2 %3 %4 | stopped: %5, unitReady: %6", _x, behaviour _x, combatMode _x, speedMode _x, stopped _x, unitReady _x]};
				case 5: { _text = format["%1 | state times: %2", _x, _x call _filterTimeVars]};
				case 5: { _text = format["%1 | waypoints: %2 , current wp is %3", _x, count waypoints group _x, currentWaypoint group _x ]};
				default { _text = ""};
			};
		};

		private _color = [0.8, 0, 1, _opacity]; // colorCivilian is too dark for text :/

		drawIcon3D [
			"#(argb,8,8,3)color(0,0,0,0)",
			_color,
			(getPosATL _x) vectorAdd [0, 0, 2],
			1, 1, 0,
			_text, 0, 0.03, "EtelkaNarrowMediumPro", "center", true
		];
	} forEach ([] call EFUNC(legacy,getGlobalCivs));

}, 0, []] call CBA_fnc_addPerFrameHandler;

if (GVAR(showInfoLine)) then {
	if (!(GVAR(actionIds) isEqualTo [])) exitWith {};

    private _addCivAction = {
        params [
            ["_title", ""],
            ["_id", 0]
        ];

        player addAction [
            _title,
            { GVAR(civStateFormat) = _this#3; },
            _id,
            10,
            false,
            false,
            "",
            QGVAR(showInfoLine)
        ];
    };

	GVAR(actionIds) = [
	    ["<t color='#3333FF'>civstate format: infoLine</t>", 0] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: speedmode</t>", 1] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: guns</t>", 2] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: locality</t>", 3] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: behaviour</t>", 4] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: state times</t>", 5] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: waypoints</t>", 6] call _addCivAction,
	    ["<t color='#3333FF'>civstate format: empty</t>", 7] call _addCivAction
	];
} else {
	{
		player removeAction _x;
	} forEach GVAR(actionIds);
	GVAR(actionIds) = [];
};
