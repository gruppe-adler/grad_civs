private _chatTime = GRAD_CIVS_CHAT_TIME * random [0.2, 1, 5];
_this setVariable ["grad_civs_chat_time", _chatTime];

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {};

[_this, format ["chatting with %1", _neighbor]] call grad_civs_fnc_setCurrentlyThinking;

_this lookAt _neighbor;
