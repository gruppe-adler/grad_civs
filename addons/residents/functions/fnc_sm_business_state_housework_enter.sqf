// TODO split between housework and housemove actions! move should stop when civ arrives at dest - housework sohulod have rfixed time

#include "..\script_component.hpp"

private _house = _this getVariable ["grad_civs_home", objNull];
_this setVariable ["grad_civs_housework_time", random [5, 15, 120]];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {};

if (random 4 > 1) then { // in 2 of 3 cases , do change position
    doStop _this;

    // add one random really close position to house positions
    private _currentPos = getPos _this;
    private _nearPos = [random 10, random 10, (_currentPos select 2)] vectorAdd _currentPos;
    private _positions = ([_house] call BIS_fnc_buildingPositions) + [_nearPos];
    private _pos = selectRandom _positions;

    _this moveTo _pos;

    _this setVariable [QGVAR(housework_anim), "### MOVING ###"];
} else {
    private _animSet = selectRandom GVAR(houseworkAnimationSets);
    [_this, _animSet, "ASIS", objNull, true] call BIS_fnc_ambientAnim;

    _this setVariable [QGVAR(housework_anim), _animSet];
};
