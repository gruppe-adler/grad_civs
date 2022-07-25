#include "..\script_component.hpp"

private _sleepLimits = _this getVariable [QGVAR(sleepLimits), []];
if (_sleepLimits isEqualTo []) then {
    _sleepLimits = [21.5 + random [0, 0.5, 2.4], 5 + random [0, 1.5, 3.5]];
    _this setVariable [QGVAR(sleepLimits), _sleepLimits];
};

(dayTime > _sleepLimits#0) || (dayTime < _sleepLimits#1)
