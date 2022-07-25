#include "..\script_component.hpp"

private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];

private _distance = _this distance _targetPos;

(_distance < 2) ||
    (_thisStateTime > 120 && _distance < 10)
