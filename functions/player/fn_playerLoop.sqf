#include "..\..\component.hpp"

[{
    if (!alive player) exitWith {};
    [] call GRAD_civs_fnc_checkWeaponOnCivilianPointer;

},1,[]] call CBA_fnc_addPerFrameHandler;
