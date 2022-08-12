#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {
    WARNING_1("%1 : wanted to meet neighbor but now he's null!", _this);
};

private _isSenior = ([_this, _neighbor] call FUNC(compare)) > 0;
private _stopDistance = _this getVariable [QGVAR(seniorStopDistance), 5];
if (
    !(isOnRoad _this) &&
    _isSenior &&
    (_this distance _neighbor) < _stopDistance &&
    (random 10 > 1)
) exitWith {
    LOG_2("%1 : as the senior talking to %2 im stopping early", _this, _neighbor);
    doStop _this;
}; // one of both may wait the last meters

private _knownNeighborPos = _this getVariable ["grad_civs_neighborPos", [0, 0, 0]];
private _neighborPos = getPos _neighbor;
if ((_knownNeighborPos distance _neighborPos) > 1) then {
    LOG_2("%1 : need to move closer to %2 to meet them", _this, _neighbor);
    _this setVariable ["grad_civs_neighborPos", _neighborPos];
    _this doMove _neighborPos;
    _this call EFUNC(activities,forceEmotionSpeed);
};
