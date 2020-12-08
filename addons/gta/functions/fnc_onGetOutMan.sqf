#include "..\script_component.hpp"

if (isNil QGVAR(stolenVehiclePfh)) exitWith {};

INFO("get out: stopping pfh");
[GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler;