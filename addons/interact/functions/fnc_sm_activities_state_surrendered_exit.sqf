#include "..\script_component.hpp"

_this enableAI "ANIM";
_this enableAI "MOVE";

if (!isNil "ACE_captives_fnc_setSurrendered") then {
    [_this, false] call ACE_captives_fnc_setSurrendered;
};

_this setVariable ["grad_civs_surrenderTime", nil];
_this setVariable [QGVAR(pointingPlayer), nil];
