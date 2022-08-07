#include "..\script_component.hpp"

ISNILS(GVAR(speedLimitsPfh), -1);

if (!GVAR(showSpeedLimitsOnMap)) exitWith {
    [GVAR(speedLimitsPfh)] call CBA_fnc_removePerFrameHandler;
    GVAR(speedLimitsPfh) = -1;
    ["delete"] call FUNC(drawSpeedLimitsOnMap);
};

if (GVAR(speedLimitsPfh) != -1) exitWith {
    WARNING("showSpeedLimitsOnMap already has pfh, not adding another one");
};

GVAR(speedLimitsPfh) = [
    {
        if (!isGameFocused || isGamePaused) exitWith {};
        ["update"] call FUNC(drawSpeedLimitsOnMap);
    },
    2,
    []
] call CBA_fnc_addPerFrameHandler;
