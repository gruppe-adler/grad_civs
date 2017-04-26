#include "..\..\component.hpp"

if (!weaponLowered player) then {

    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];

    /* if cursortarget is not of man/car anymore */
    if (!(cursorTarget isKindOf "Car" || cursorTarget isKindOf "Man")) exitWith {

        /* remove my marker on civ, if i dont target him anymore */
        if (!(_currentCiv isEqualTo (driver cursorTarget))) then {
            [_currentCiv] call GRAD_civs_fnc_removePointerTick;
        };

    };

    // make sure driver is taken, check later for crew. default is object itself.
    _possibleCiv = driver cursorTarget;

    if (_possibleCiv getVariable ["GRAD_isFleeing", false]) exitWith {};

    /* check if cached civ is the same as the new target and exit*/
    if (!isNull _currentCiv && {!(_possibleCiv isEqualTo _currentCiv)}) exitWith {

    };

    /* if civ is civ, alive and closer than 50m, make him target */
    if ( (side _possibleCiv) == civilian && {alive _possibleCiv} && {player distance _possibleCiv < 50}) then {
        _civ = _possibleCiv;

        /* if i dont already point at him */
        if (isNull _currentCiv) then {
            [_civ] remoteExec ["GRAD_civs_fnc_stopCiv", [2,0] select (isMultiplayer && isDedicated), false];
        };

        [_civ] call GRAD_civs_fnc_addPointerTick;

    };

} else {
    /* lowering weapon should remove civ pointer as well */
    _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];

    if (!isNull _currentCiv) then {
        [_currentCiv] call GRAD_civs_fnc_removePointerTick;
    };
};
