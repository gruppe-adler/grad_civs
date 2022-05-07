#include "..\script_component.hpp"

private _flightpoint = _this getVariable ["grad_civs_flightpoint", [0, 0, 0]];
if (((_this distance _flightpoint) < 2) || (_flightpoint isEqualTo  [0, 0, 0])) then {
    private _pos = [leader _this, [150,300], [0,360]] call FUNC(findRandomPos);
    _this setVariable ["grad_civs_flightpoint", _pos];
    _this doMove _pos;
    _this call FUNC(forceEmotionSpeed);
};
