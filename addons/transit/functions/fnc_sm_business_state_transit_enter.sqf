#include "..\script_component.hpp"

private _target = (group _this) getVariable [QGVAR(destination), [0, 0, 0]];
[group _this, _target, [0, 0, 0], 5] call EFUNC(patrol,taskPatrolAddWaypoint);
_this setSpeedMode "LIMITED";
_this forceSpeed -1;
_this enableDynamicSimulation true;
_this doFollow _this;
