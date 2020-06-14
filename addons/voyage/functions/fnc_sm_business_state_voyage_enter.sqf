#include "..\script_component.hpp"

[_this, _this, 2500, 3, [0,0,0], false, true] call EFUNC(patrol,taskPatrol); // vehicle patrol: wide range
_this setSpeedMode "LIMITED";
_this forceSpeed -1;
_this enableDynamicSimulation true;
_this doFollow _this;
