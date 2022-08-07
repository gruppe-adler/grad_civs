#include "..\script_component.hpp"

ISNILS(GVAR(customSpeedLimits), []); // Array<(Location, number)>
ISNILS(GVAR(townSpeedLimits), ([] call FUNC(determineTownLocations)) apply {[ARR_2(_x, GVAR(townSpeedLimit))]});

GVAR(townSpeedLimits) + GVAR(customSpeedLimits)
