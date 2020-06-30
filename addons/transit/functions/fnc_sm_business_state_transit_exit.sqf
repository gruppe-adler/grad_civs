#include "..\script_component.hpp"

[group _this] call CBA_fnc_clearWaypoints;
_this call EFUNC(legacy,clearCurrentlyThinking);
