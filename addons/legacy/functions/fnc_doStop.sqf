#include "..\script_component.hpp"

params [
    ["_object", objNull, [objNull]],
    ["_waitTime", -1, [0]]
];

if (_waitTime == -1) then {
    _waitTime = 999999;
};

if (local _object) exitWith {
    if (_object == ACE_player) exitWith {};
    [
        _object,
        {
            params ["_object"];
            _object setVariable [QGVAR(stopped), true, true];
            doStop _object;
            _object disableAI "MOVE";
        },
        {
            params ["_object"];
            _object enableAI "MOVE";
            _object setVariable [QGVAR(stopped), nil, true];
        },
        _waitTime,
        [],
        "doStop",
        format["am halting, will resume activity at %1", _waitTime call EFUNC(common,formatNowPlusSeconds)]
    ] call FUNC(doCustomActivity);
};

[
    QGVAR(doStop),
    [_object, _waitTime],
    _object
] call CBA_fnc_targetEvent;
