#include "..\script_component.hpp"

private _baseChatTime = GVAR(chatTime);

private _chatTime = _baseChatTime * random [0.2, 1, 5];
_this setVariable [QGVAR(chatDuration), _chatTime];

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {};

_this lookAt _neighbor;
