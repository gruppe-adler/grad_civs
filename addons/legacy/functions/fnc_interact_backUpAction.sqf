#include "..\script_component.hpp"

private _veh = vehicle _target;
private _reverseTargetPos = (getPos _veh) vectorAdd ((vectorDir _veh) vectorMultiply -50);

[_target, _reverseTargetPos] call FUNC(customActivity_reverse);
