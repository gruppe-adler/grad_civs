#include "..\script_component.hpp"

private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];

(_this distance _targetPos) < 2
