// TODO housework sohulod have rfixed time

#include "..\script_component.hpp"

private _house = _this getVariable ["grad_civs_home", objNull];
_this setVariable ["grad_civs_housework_time", random [5, 15, 120]];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {
    LOG_1("%1 should be doing housework, but does not have a house");
};

private _animSet = selectRandom GVAR(houseworkAnimationSets);
[_this, _animSet, "ASIS", objNull, true] call BIS_fnc_ambientAnim;

_this setVariable [QGVAR(housework_anim), _animSet];
