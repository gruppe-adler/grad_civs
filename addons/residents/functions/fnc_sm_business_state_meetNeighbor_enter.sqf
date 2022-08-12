#include "..\script_component.hpp"

[QEGVAR(common,switchMove), [_this, ""]] call CBA_fnc_globalEvent;
doStop _this;
private _stopDistance = random [3, 7, 20];
LOG_2("%1 : stop distance for chat if senior is %2", _this, _stopDistance);
_this setVariable [QGVAR(seniorStopDistance), _stopDistance];
