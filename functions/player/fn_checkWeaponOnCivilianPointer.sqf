#include "..\..\component.hpp"

scopeName "checkPointer_main";

if (!weaponLowered player) then {

    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];
    _possibleCiv = driver cursorTarget;

    /* remove my marker on civ, if i dont target him anymore */
    if !(_currentCiv isEqualTo _possibleCiv) then {
        if (!isNull _currentCiv) then {
            player setVariable ["GRAD_isPointingAtObj", objNull];
            [_currentCiv,player] remoteExec ["grad_civs_fnc_removePointerTick",2,false];
        };
    } else {
        breakTo "checkPointer_main";
    };

    if (!(_possibleCiv isKindOf "Man") && {!(_possibleCiv isKindOf "Car")}) exitWith {};

    /* don't stop civ if fleeing */
    if (_possibleCiv getVariable ["GRAD_isFleeing", false]) exitWith {};

    /* if civ is civ, alive and closer than 50m, make him target */
    if ((side _possibleCiv) == civilian && {alive _possibleCiv} && {player distance _possibleCiv < 50} && {!isPlayer _possibleCiv}) then {

        [_possibleCiv] remoteExec ["grad_civs_fnc_stopCiv",_possibleCiv,false];
        player setVariable ["GRAD_isPointingAtObj", _possibleCiv];
        [_possibleCiv,player] remoteExec ["grad_civs_fnc_addPointerTick",2,false];
    };

} else {
    /* lowering weapon should remove civ pointer as well */
    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];

    if (!isNull _currentCiv) then {
        player setVariable ["GRAD_isPointingAtObj", objNull];
        [_currentCiv,player] remoteExec ["grad_civs_fnc_removePointerTick",2,false];
    };
};
