#include "..\..\component.hpp"

params ["_handle", "_vehicle", "_targetPos", "_tryAtLeastUntil", "", "_abortCondition"];
private _nowDst = (_targetPos distance _vehicle);
private _prevDst = _vehicle getVariable ["grad_civs_reverse_dst", 100000];
_vehicle setVariable ["grad_civs_reverse_dst", _nowDst];
((_vehicle distance _targetPos) < TARGET_PRECISION) ||
    ((_nowDst > _prevDst) && (CBA_missionTime > _tryAtLeastUntil)) ||
    ([_vehicle] call _abortCondition) ||
    (_vehicle getVariable [QGVAR(abortReverse), false])
