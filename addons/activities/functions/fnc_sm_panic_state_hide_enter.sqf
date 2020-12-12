#include "..\script_component.hpp"

private _pos = [_this, true] call FUNC(findPositionOfInterest);
_this setVariable ["grad_civs_hidepoint", _pos];
_this doMove _pos;
_this setSpeedMode "FULL";
_this forceSpeed (_this getVariable ["grad_civs_runspeed", 20]);
