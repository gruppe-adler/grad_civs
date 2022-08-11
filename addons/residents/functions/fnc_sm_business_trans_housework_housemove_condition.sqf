#include "..\script_component.hpp"

private _result = (_this getVariable [QGVAR(housework_time), 0]) + _thisStateTime < CBA_missionTime;

LOG_2("%1 : is housework over? %2", _this, _result);

_result
