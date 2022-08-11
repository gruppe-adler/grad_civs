#include "..\script_component.hpp"

private _house = _this getVariable ["grad_civs_home", objNull];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {
    LOG_1("%1 should be doing housemove, but dont have a house", _this);
};

doStop _this;

private _positions = [_house] call BIS_fnc_buildingPositions;

if (!(_this call EFUNC(activities,isSleepingTime))) then {
    // add one random really close position to house positions
    private _currentPos = getPos _house;
    private _offsetFromHouse = [random 10, random 10, (_currentPos select 2)];
    LOG_2("%1 its day so lets add one housework position outside the house", _this, _offsetFromHouse);
    private _nearPos = _offsetFromHouse vectorAdd _currentPos;
    _positions = _positions + [_nearPos];
};

private _pos = selectRandom _positions;

_this moveTo _pos;

_this setVariable [QGVAR(targetPos), _pos];
