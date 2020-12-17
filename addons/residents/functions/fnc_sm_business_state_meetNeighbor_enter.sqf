#include "..\script_component.hpp"

[QEGVAR(common,switchMove), [_this, ""]] call CBA_fnc_globalEvent;
doStop _this;
_this setVariable ["grad_civs_stopDistance", random [3, 7, 20]];
private _neighborToMeet = _this getVariable ["grad_civs_neighborToMeet", objNull];
