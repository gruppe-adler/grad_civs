#include "..\..\component.hpp"

[{
    params ["_args", "_handle"];

    if (!alive player) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

    call GRAD_civs_fnc_checkWeaponOnCivilianPointer;

},1,[]] call CBA_fnc_addPerFrameHandler;
