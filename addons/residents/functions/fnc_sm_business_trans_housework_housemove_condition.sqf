#include "..\script_component.hpp"

private _result = (_this getVariable [QGVAR(housework_time), 0]) + _thisStateTime < CBA_missionTime;

_result
