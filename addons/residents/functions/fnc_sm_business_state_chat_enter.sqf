#include "..\script_component.hpp"

private _baseChatTime = [QGVAR(chatTime)] call CBA_settings_fnc_get;

private _chatTime = _baseChatTime * random [0.2, 1, 5];
_this setVariable ["grad_civs_chat_time", _chatTime];

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {};

[_this, format ["chatting with %1", _neighbor]] call EFUNC(legacy,setCurrentlyThinking);

_this lookAt _neighbor;
