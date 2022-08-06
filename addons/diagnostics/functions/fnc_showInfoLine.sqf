#include "..\script_component.hpp"

ISNILS(GVAR(civStateFormat), 0);
ISNILS(GVAR(userActionIds), []);

[{
    params [
        ["_args", [], [[]]],
        ["_handle", 0, [0]]
    ];
    if (!(GVAR(showInfoLine))) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    if (!isGameFocused || isGamePaused) exitWith {};

    private _filterTimeVars = {
        ((allVariables _this) select {
            (_x find "grad_civs_state_time_") > -1
        } apply {
            [_x, floor CBA_missionTime - (_this getVariable _x)] joinString ": "
        }) joinString ", ";
    };

    private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
    private _camDir = getCameraViewDirection (call CBA_fnc_currentUnit);

    {
        private _opacity = linearConversion [500, 50, _camPos distance _x, 0.2, 1, true];

        private _diff = (getPosASL _x) vectorDiff _camPos;
        private _civAngle = acos (_camDir vectorCos _diff);

        private _fov = deg getObjectFOV (call CBA_fnc_currentUnit);

        private _text = if (_civAngle < _fov) then {
            switch (GVAR(civStateFormat)) do {
                case 0: {""};
                case 1: {_x getVariable [QGVAR(infoLine),"<no info found. is debug mode enabled where the civs are local?>"]; };
                case 2: {
                    private _veh = vehicle _x;
                    private _driver = driver _veh;
                    if ((_veh != _x) && (_driver != _x)) exitWith { "x" };

                    format["%1 | %2km/h in speedmode: %3 %4", _x, round speed _veh, speedMode _x, if (leader _x == _x) then {"(is leader)"} else {""}];
                };
                case 3: {format["%1 | %2 guns point at him", _x, _x getVariable [QEGVAR(interact,pointedAtCount), 0]]};
                case 4: {format["%1 | is local at %2", _x, _x getVariable [QGVAR(localAt), 0]]};
                case 5: {format["%1 | %2 %3 %4 | stopped: %5, unitReady: %6", _x, behaviour _x, combatMode _x, speedMode _x, stopped _x, unitReady _x]};
                case 6: {format["%1 | state times: %2", _x, _x call _filterTimeVars]};
                case 7: {format["%1 | waypoints: %2 , current wp is %3", _x, count waypoints group _x, currentWaypoint group _x ]};
                case 8: {format["%1 | distance to player: %2", _x, _x distance (call CBA_fnc_currentUnit)]};
                case 9: {format["%1 | %2%3", _x, typeOf _x, if (vehicle _x != _x) then {format [" in %1", typeOf (vehicle _x)]} else {""}]};
                case 10: {
                    private _vic = vehicle _x;
                    if (_vic != _x && (driver _vic == _x)) then {
                        private _i = vehicleMoveInfo _vic;
                        private _ec = effectiveCommander _vic;
                        if (isObjectHidden _ec) then {
                            _ec hideObject false;
                        };
                        format["%1 | commander %2 | move %3 | turn %4", _x, _ec, _i#0, _i#1];
                    } else {
                        ""
                    };
                };
                case 11: {format[
                    "%1 | houseworkanim: %2, animState %3, gestureState %4, pose %5",
                    _x,
                    _x getVariable [QEGVAR(residents,housework_anim), ""],
                    animationState _x,
                    gestureState _x,
                    pose _x
                ]};
                default {"<empty>"};
            };
        } else {"o"};

        private _color = [0.8, 0, 1, _opacity]; // colorCivilian is too dark for text :/

        drawIcon3D [
            "#(argb,8,8,3)color(0,0,0,0)",
            _color,
            (getPosATLVisual _x) vectorAdd [0, 0, 1.85],
            1, 1, 0,
            _text, 0, 0.03, "EtelkaNarrowMediumPro", "center", true
        ];
    } forEach ([] call EFUNC(lifecycle,getGlobalCivs));

}, 0, []] call CBA_fnc_addPerFrameHandler;

if (GVAR(showInfoLine)) then {
    if (!(GVAR(userActionIds) isEqualTo [])) exitWith {};

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

    GVAR(userActionIds) = [
        ["<t color='#3333FF'>civstate format: empty</t>", 0] call _addCivAction,
        ["<t color='#3333FF'>civstate format: infoLine</t>", 1] call _addCivAction,
        ["<t color='#3333FF'>civstate format: speed</t>", 2] call _addCivAction,
        ["<t color='#3333FF'>civstate format: guns</t>", 3] call _addCivAction,
        ["<t color='#3333FF'>civstate format: locality</t>", 4] call _addCivAction,
        ["<t color='#3333FF'>civstate format: behaviour</t>", 5] call _addCivAction,
        ["<t color='#3333FF'>civstate format: state times</t>", 6] call _addCivAction,
        ["<t color='#3333FF'>civstate format: waypoints</t>", 7] call _addCivAction,
        ["<t color='#3333FF'>civstate format: distance</t>", 8] call _addCivAction,
        ["<t color='#3333FF'>civstate format: type</t>", 9] call _addCivAction,
        ["<t color='#3333FF'>civstate format: vehicle move info</t>", 10] call _addCivAction,
        ["<t color='#3333FF'>civstate format: animations</t>", 11] call _addCivAction
    ];
} else {
    {
        player removeAction _x;
    } forEach GVAR(userActionIds);
    GVAR(userActionIds) = [];
};
