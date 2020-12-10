#include "..\script_component.hpp"

if (isNil QGVAR(stolenVehiclePfh)) exitWith {};

INFO("player dismounting: stop witness watch (was it even running?)");
[GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler;
GVAR(stolenVehiclePfh) = nil;
