[_this, _this, 2500, 3, [0,0,0], false, true] call grad_civs_fnc_taskPatrol; // vehicle patrol: wide range
_this setSpeedMode "LIMITED";
_this forceSpeed -1;
_this enableDynamicSimulation true;
_this doFollow _this;
