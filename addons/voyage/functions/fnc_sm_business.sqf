#include "..\script_component.hpp"

params [
    ["_business", locationNull, [locationNull]]
];

private _bus_rally = "bus_rally";
/**
 * part of the voyage cycle: mount up, voyage, dismount
 */
private _bus_mountUp = [
    _business,
    {},
    { _this call FUNC(sm_business_state_mountUp_enter) },
    { _this call FUNC(sm_business_state_mountUp_exit) },
    "bus_mountUp"
] call EFUNC(cba_statemachine,addState);

private _bus_voyage  = [
    _business,
    { _this call FUNC(sm_business_state_voyage_loop) },
    { _this call FUNC(sm_business_state_voyage_enter) },
    { _this call FUNC(sm_business_state_voyage_exit) },
    "bus_voyage"
] call EFUNC(cba_statemachine,addState);

private _bus_dismount  = [
    _business,
    {},
    { _this call FUNC(sm_business_state_dismount_enter) },
    {},
    "bus_dismount"
] call EFUNC(cba_statemachine,addState);

    // TRANSITIONS voyage:

assert ([
    _business,
    _bus_rally, _bus_mountUp,
    { _this call FUNC(sm_business_trans_rally_mountUp_condition) },
    {},
    _bus_rally + _bus_mountUp
] call EFUNC(cba_statemachine,addTransition));

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
            [_this, nil] call FUNC(setGroupVehicle);
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

assert ([
    _business,
    _bus_mountUp, _bus_dismount,
    { _this call FUNC(sm_business_trans_mountUp_dismount_condition) },
    {},
    _bus_mountUp + _bus_dismount
] call EFUNC(cba_statemachine,addTransition));


assert ([
    _business,
    _bus_dismount, _bus_rally,
    { _this call FUNC(sm_business_trans_dismount_rally_condition) },
    {},
    _bus_dismount + _bus_rally
] call EFUNC(cba_statemachine,addTransition));

_business
