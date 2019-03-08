#include "..\..\component.hpp"

[{
    [] call grad_civs_fnc_checkWeaponOnCivilianPointer;
}, 0.5, []] call CBA_fnc_addPerFrameHandler;

GRAD_CIVS_PLAYERSIDE = sideUnknown;

[{
    if !(alive player) exitWith {};
    if (GRAD_CIVS_PLAYERSIDE == side player) exitWith {};

    if (side player == civilian) then {
        GRAD_CIVS_INFOCHANNEL radioChannelAdd [player];
        ["you are CIVILIAN now"] call grad_civs_fnc_showCivHint;
    } else { if (GRAD_CIVS_PLAYERSIDE == civilian) then {
        ["you are NO LONGER CIVILIAN"] call grad_civs_fnc_showCivHint;
        GRAD_CIVS_INFOCHANNEL radioChannelRemove [player];
    }};
    GRAD_CIVS_PLAYERSIDE = side player;
}, 5, []] call CBA_fnc_addPerFrameHandler;
