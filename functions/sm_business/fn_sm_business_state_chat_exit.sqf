#include "..\..\component.hpp"

_this setVariable["grad_civs_lastSocialContact", CBA_missionTime];
_this setVariable ["grad_civs_chat_time", nil];
_this setVariable ["grad_civs_neighborToMeet", nil];
_this setRandomLip false;
_this call grad_civs_fnc_clearCurrentlyThinking;
