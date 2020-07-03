#include "..\script_component.hpp"

private _leader = leader _this;

/*if leader is calling for mounting up: get in*/
if (([_leader, "business"] call EFUNC(common,civGetState)) == "bus_mountUp") then { // TODO resolve circular dependency
    private _veh = _this call EFUNC(cars,getGroupVehicle); // TODO resolve circular dependency - create new "passenger" state for passengers
    if (_veh != vehicle _this) then {
        _this assignAsCargo _veh;
        [_this] orderGetIn true;
    };
} else {
    /*if leader is unmounted, and I'm not: get out*/
    if ((_leader == vehicle _leader) && (_this != vehicle _this)) then {
        unassignVehicle _this;
    };
};
