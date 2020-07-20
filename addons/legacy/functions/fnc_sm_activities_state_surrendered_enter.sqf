#include "..\script_component.hpp"

_this setVariable ["grad_civs_surrenderTime", CBA_missionTime];
[_this, true] call ACE_captives_fnc_setSurrendered;
_this disableAI "MOVE";
_this disableAI "ANIM";
