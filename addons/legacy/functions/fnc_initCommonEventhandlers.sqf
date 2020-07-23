#include "..\script_component.hpp"

[QGVAR(switchMove), {
        params ["_unit", "_animation"];
        _unit switchMove _animation;
    }
] call CBA_fnc_addEventHandler;

["ace_common_playActionNow", {
    params ["_unit", "_animation"];
    if (!local _unit) exitWith {
        WARNING_2("got playActionNow event %1 non-local unit %2!", _animation _unit);
    };
    [_unit, _animation] call FUNC(handleAnimation);
}] call CBA_fnc_addEventHandler;


[QGVAR(doStop), {
    params [
        ["_target", objNull, [objNull]],
        ["_waitTime", 0, [0]]
    ];
    [_target, _waitTime] call FUNC(doStop);
}] call CBA_fnc_addEventHandler;

[QGVAR(doCarryOn), {
    params [
        ["_target", objNull, [objNull]]
    ];
    [_target] call FUNC(doCarryOn);
}] call CBA_fnc_addEventHandler;
