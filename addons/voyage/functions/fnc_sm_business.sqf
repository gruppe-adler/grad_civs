#include "..\script_component.hpp"

params [
    ["_business", locationNull, [locationNull]]
];
assert(!(isNull _business));

private _bus_rally = "bus_rally";
private _bus_mountUp = "bus_mountUp";
private _bus_dismount = "bus_dismount";

// STATES

private _bus_voyage  = [
    _business,
    { _this call FUNC(sm_business_state_voyage_loop) },
    { _this call FUNC(sm_business_state_voyage_enter) },
    { _this call FUNC(sm_business_state_voyage_exit) },
    "bus_voyage"
] call EFUNC(cba_statemachine,addState);

// TRANSITIONS

assert ([
    _business,
    _bus_mountUp, _bus_voyage,
    { _this call FUNC(sm_business_trans_mountUp_voyage_condition) },
    {},
    _bus_mountUp + _bus_voyage
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _business,
    _bus_voyage, _bus_dismount,
    { _this call FUNC(sm_business_trans_voyage_dismount_condition) },
    {
        if (!(canMove vehicle _this)) then {
            [_this, nil] call EFUNC(cars,setGroupVehicle);
        }
    },
    _bus_voyage + _bus_dismount
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _business,
    _bus_voyage, _bus_dismount,
    ["grad_civs_panicking"],
    { _this setSpeedMode "FULL"; speed vehicle _this < 30 },
    {},
    _bus_voyage + _bus_dismount
] call CBA_statemachine_fnc_addEventTransition);

_business
