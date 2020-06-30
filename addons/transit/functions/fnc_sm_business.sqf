#include "..\script_component.hpp"

params [
    ["_business", locationNull, [locationNull]]
];
assert(!(isNull _business));

// assume voyage states exist

private _bus_rally = "bus_rally";
private _bus_dismount = "bus_dismount";
private _bus_mountUp = "bus_mountUp";

private _bus_transit  = [
    _business,
    { _this call FUNC(sm_business_state_transit_loop) },
    { _this call FUNC(sm_business_state_transit_enter) },
    { _this call FUNC(sm_business_state_transit_exit) },
    "bus_transit"
] call EFUNC(cba_statemachine,addState);

assert ([
    _business,
    _bus_mountUp, _bus_transit,
    { _this call FUNC(sm_business_trans_mountUp_transit_condition) },
    {},
    _bus_mountUp + _bus_transit
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _business,
    _bus_transit, _bus_dismount,
    { _this call FUNC(sm_business_trans_transit_dismount_condition) },
    {
        if (!(canMove vehicle _this)) then {
            [_this, nil] call EFUNC(cars,setGroupVehicle);
        }
    },
    _bus_transit + _bus_dismount
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _business,
    _bus_transit, _bus_dismount,
    ["grad_civs_panicking"],
    { _this setSpeedMode "FULL"; speed vehicle _this < 30 },
    {},
    _bus_transit + _bus_dismount
] call CBA_statemachine_fnc_addEventTransition);

_business
