#include "..\..\component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {WARNING("wanted to meet neighbor, but now he's  null!")};

private _isSenior = ([_this, _neighbor] call grad_civs_fnc_compare) > 0;
private _stopDistance = _this getVariable ["grad_civs_stopDistance", 5];
if (!(isOnRoad _this) && _isSenior && (_this distance _neighbor) < _stopDistance && (random 10 > 1)) exitWith {doStop _this}; // one of both may wait the last meters

private _knownNeighborPos = _this getVariable ["grad_civs_neighborPos", [0, 0, 0]];
private _neighborPos = getPos _neighbor;
if ((_knownNeighborPos distance _neighborPos) > 1) then {
    _this setVariable ["grad_civs_neighborPos", _neighborPos];
    _this doMove _neighborPos;
    _this call grad_civs_fnc_forceBusinessSpeed;
};
