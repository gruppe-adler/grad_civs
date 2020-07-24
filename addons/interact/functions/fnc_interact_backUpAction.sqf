#include "..\script_component.hpp"

private _veh = vehicle _target;
private _reverseTargetPos = (getPos _veh) vectorAdd ((vectorDir _veh) vectorMultiply -50);

[
    QGVAR(told_to_reverse),
    [_target, _reverseTargetPos],
    _target
] call CBA_fnc_targetEvent;
