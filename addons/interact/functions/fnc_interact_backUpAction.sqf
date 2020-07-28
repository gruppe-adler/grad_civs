#include "..\script_component.hpp"

private _veh = vehicle _target;
private _driver = driver _veh;

if (isNull _driver) exitWith {
    ERROR_1("cannot back up vehicle %1 without driver!", _veh);
};

private _reverseTargetPos = (getPos _veh) vectorAdd ((vectorDir _veh) vectorMultiply -50);

[
    QGVAR(told_to_reverse),
    [_driver, _reverseTargetPos],
    _driver
] call CBA_fnc_targetEvent;
