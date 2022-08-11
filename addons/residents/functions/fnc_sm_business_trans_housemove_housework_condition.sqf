#include "..\script_component.hpp"

private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];
private _distance = _this distance _targetPos;

if (_distance < 2) exitWith {
    LOG_3("%1 : entering housework as distance to %2 is %3", _this, _targetPos, _distance);
    true
};

if ((_thisStateTime + 120) < CBA_missionTime && (_distance < 10)) exitWith {
    LOG_3("%1 : trying to reach destination for >120s and distance to %2 is %3 - entering housework for a change", _this, _targetPos, _distance);
    true
};

false
