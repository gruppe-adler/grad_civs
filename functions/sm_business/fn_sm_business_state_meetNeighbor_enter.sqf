#include "..\..\component.hpp"

[QGVAR(switchMove), [_this, ""]] call CBA_fnc_globalEvent;
doStop _this;
_this setVariable ["grad_civs_stopDistance", random [3, 7, 20]];
private _neighborToMeet = _this getVariable ["grad_civs_neighborToMeet", objNull];
[_this, format ["going to chat with %1", _neighborToMeet]] call grad_civs_fnc_setCurrentlyThinking;
