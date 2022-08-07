#include "..\script_component.hpp"

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

private _playerUnit = call CBA_fnc_currentUnit;
private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
private _camDir = getCameraViewDirection _playerUnit;
private _fov = deg getObjectFOV _playerUnit;


{
    private _opacity = linearConversion [500, 50, _camPos distance _x, 0.2, 1, true];

    private _diff = (getPosASL _x) vectorDiff _camPos;
    private _civAngle = acos (_camDir vectorCos _diff);



    private _text = if (_civAngle < _fov) then {
        switch (GVAR(civStateFormat)) do {
            case 0: {""};
            case 1: {_x getVariable [QGVAR(infoLine),"<no info found. is debug mode enabled where the civs are local?>"]; };
            case 2: {
                private _veh = vehicle _x;
                private _driver = driver _veh;
                if ((_veh != _x) && (_driver != _x)) exitWith { "x" };

                format["%1 | %2 / %3 km/h in speedmode: %4 %5",
                    _x,
                    round speed _veh,
                    round (_veh getVariable [QEGVAR(cars,speedLimit), -1]),
                    speedMode _x,
                    if (leader _x == _x) then {"(is leader)"} else {""}
                ];
            };
            case 3: {format["%1 | %2 guns point at him", _x, _x getVariable [QEGVAR(interact,pointedAtCount), 0]]};
            case 4: {format["%1 | is local at %2", _x, _x getVariable [QGVAR(localAt), 0]]};
            case 5: {format["%1 | %2 %3 %4 | stopped: %5, unitReady: %6", _x, behaviour _x, combatMode _x, speedMode _x, stopped _x, unitReady _x]};
            case 6: {format["%1 | state times: %2", _x, _x call _filterTimeVars]};
            case 7: {format["%1 | waypoints: %2 , current wp is %3", _x, count waypoints group _x, currentWaypoint group _x ]};
            case 8: {format["%1 | distance to player: %2", _x, _x distance _playerUnit]};
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
    } else {
        if ((GVAR(civStateFormat)) == 0) then {""} else {"o"}
    };

    private _color = [0.8, 0, 1, _opacity]; // colorCivilian is too dark for text :/

    drawIcon3D [
        "#(argb,8,8,3)color(0,0,0,0)",
        _color,
        (getPosATLVisual _x) vectorAdd [0, 0, 1.85],
        1, 1, 0,
        _text, 0, 0.03, "EtelkaNarrowMediumPro", "center", true
    ];
} forEach ([] call EFUNC(lifecycle,getGlobalCivs));
