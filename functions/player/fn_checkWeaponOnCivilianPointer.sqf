#include "..\..\component.hpp"

scopeName "checkPointer_main";

if ((alive player) && (!weaponLowered player) && (vehicle player == player)) then {

    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];
    _possibleCiv = driver cursorTarget;

    /* remove my marker on civ, if i dont target him anymore */
    if !((_currentCiv isEqualTo _possibleCiv) || (cursorTarget isEqualTo (_currentCiv call grad_civs_fnc_getGroupVehicle))) then {
        if (!isNull _currentCiv) then {
            player setVariable ["GRAD_isPointingAtObj", objNull];
            if (GRAD_CIVS_DEBUG_CIVSTATE) then { hint format ["depointing %1", _currentCiv]; };
            ["pointed_at_dec", [_currentCiv], [_currentCiv]] call CBA_fnc_targetEvent;
        };
    } else {
        breakTo "checkPointer_main";
    };

    if (!(_possibleCiv isKindOf "Man") && {!(_possibleCiv isKindOf "Car")}) exitWith {};

    /* if civ is civ, alive and they perceive you as a threat, make them a target */
    if ((side _possibleCiv) == civilian && (alive _possibleCiv)) then {
        if ([player, _possibleCiv] call grad_civs_fnc_checkWeaponOnCivilianPerception) then {
            player setVariable ["GRAD_isPointingAtObj", _possibleCiv];
            if (GRAD_CIVS_DEBUG_CIVSTATE) then { hint format ["pointing at %1", _possibleCiv]; };
            ["pointed_at_inc", [_possibleCiv], [_possibleCiv]] call CBA_fnc_targetEvent;
        };
    };

} else {
    /* lowering weapon should remove civ pointer as well */
    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];

    if (!isNull _currentCiv) then {
        player setVariable ["GRAD_isPointingAtObj", objNull];
        if (GRAD_CIVS_DEBUG_CIVSTATE) then { hint format ["depointing %1", _currentCiv]; };
        ["pointed_at_dec", [_currentCiv], [_currentCiv]] call CBA_fnc_targetEvent;
    };
};
