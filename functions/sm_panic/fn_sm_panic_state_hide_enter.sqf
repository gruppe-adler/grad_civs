private _pos = [_this, true] call grad_civs_fnc_findPositionOfInterest;
[_this, format ["going to pos %1 (still %2m) to hide", _pos, _this distance _pos]] call grad_civs_fnc_setCurrentlyThinking;
_this setVariable ["grad_civs_hidepoint", _pos];
_this doMove _pos;
_this setSpeedMode "FULL";
_this forceSpeed (_this getVariable ["grad_civs_runspeed", 20]);
