#include "..\script_component.hpp"

private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];

private _distance = _this distance _targetPos;

LOG_2("housemove->housework: distance %1 statetime %2", _distance, _thisStateTime);

(_distance < 2) ||
    (_thisStateTime > 120 && _distance < 10)
