#include "..\script_component.hpp"

params [
    ["_object", objNull, [objNull]]
];

if (!(local _object)) exitWith {
    [
        QGVAR(doCarryOn),
        [_object],
        _object
    ] call CBA_fnc_targetEvent;
};

if (_object == (call CBA_fnc_currentUnit)) exitWith {};

_object call FUNC(endCustomActivity);
