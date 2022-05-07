#include "..\script_component.hpp"

private _veh = _this call FUNC(getGroupVehicle);
if (canMove _veh) then {
    _this assignAsDriver _veh;
    [_this] orderGetIn true;
} else {
    [_this, nil] call FUNC(setGroupVehicle);
};
