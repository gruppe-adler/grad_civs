// TODO housework sohulod have rfixed time

#include "..\script_component.hpp"

private _isSleepingTime = _this call EFUNC(activities,isSleepingTime);

private _house = _this getVariable ["grad_civs_home", objNull];
_this setVariable [QGVAR(housework_time), random if (_isSleepingTime) then {GVAR(houseworkTimesNight)} else {GVAR(houseworkTimesDay)}];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {
    LOG_1("%1 should be doing housework, but does not have a house");
};

private _animSets = if (_this call EFUNC(activities,isInHouse))
then {
    if (_this call EFUNC(activities,isSleepingTime))
    then { GVAR(houseworkAnimationSetsInhouseNight) }
    else { GVAR(houseworkAnimationSetsInhouseDay) }
} else { GVAR(houseworkAnimationSetsOutdoors) };


private _animSet = selectRandom _animSets;
[_this, _animSet, "ASIS", objNull, true] call BIS_fnc_ambientAnim;

_this setVariable [QGVAR(housework_anim), _animSet];
