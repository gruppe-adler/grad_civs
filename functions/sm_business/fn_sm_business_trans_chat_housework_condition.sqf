#include "..\..\component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {true};
if (isNull (_neighbor getVariable ["grad_civs_neighborToMeet", objNull])) exitWith {true};

(_this getVariable ["grad_civs_chat_time", 0]) + _thisStateTime < CBA_missionTime
