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

if (_object == ACE_player) exitWith {};

_object call FUNC(endCustomActivity);
