#include "..\script_component.hpp"

private _grpVeh = _this call FUNC(getGroupVehicle);

if (vehicle _this != _grpVeh) then {
    _this assignAsCargo _grpVeh;
    [_this] orderGetIn true;
};
