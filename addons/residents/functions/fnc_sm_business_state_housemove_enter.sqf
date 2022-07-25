#include "..\script_component.hpp"

private _house = _this getVariable ["grad_civs_home", objNull];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {
    LOG_1("%1 should be doing housemove, but does not have a house");
};

doStop _this;

private _positions = [_house] call BIS_fnc_buildingPositions;

if (!(_this call EFUNC(activities,isSleepingTime))) then {
    // add one random really close position to house positions
    private _currentPos = getPos _house;
    private _nearPos = [random 10, random 10, (_currentPos select 2)] vectorAdd _currentPos;
    _positions = _positions + [_nearPos];
};

private _pos = selectRandom _positions;

_this moveTo _pos;

_this setVariable [QGVAR(targetPos), _pos];
