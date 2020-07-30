#include "..\script_component.hpp"

params [
    ["_business", locationNull, [locationNull]]
];

assert(!(isNull _business));

private _bus_rally = "bus_rally";

private _bus_mountUp = [
    _business,
    {},
    { _this call FUNC(sm_business_state_mountUp_enter) },
    { _this call FUNC(sm_business_state_mountUp_exit) },
    "bus_mountUp"
] call EFUNC(cba_statemachine,addState);

private _bus_dismount  = [
    _business,
    {},
    { _this call FUNC(sm_business_state_dismount_enter) },
    {},
    "bus_dismount"
] call EFUNC(cba_statemachine,addState);

private _bus_rideInBack = [
    _business,
    {},
    { _this call FUNC(sm_business_state_rideInBack_enter) },
    { _this call FUNC(sm_business_state_rideInBack_exit) },
    "bus_rideInBack"
] call EFUNC(cba_statemachine,addState);

private _bus_trafficJam = [
    _business,
    {},
    { _this call FUNC(sm_business_state_trafficJam_enter) },
    { _this call FUNC(sm_business_state_trafficJam_exit) },
    "bus_trafficJam"
] call EFUNC(cba_statemachine,addState);

// TRANSITIONS

assert ([
    _business,
    _bus_rally, _bus_mountUp,
    { _this call FUNC(sm_business_trans_rally_mountUp_condition) },
    {},
    _bus_rally + _bus_mountUp
] call EFUNC(cba_statemachine,addTransition));

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

assert ([
    _business,
    _bus_rally, _bus_rideInBack,
    { _this call FUNC(sm_business_trans_rally_rideInBack_condition) },
    {},
    _bus_rally + _bus_rideInBack
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _business,
    _bus_rideInBack, _bus_rally,
    { _this call FUNC(sm_business_trans_rideInBack_rally_condition) },
    {},
    _bus_rideInBack + _bus_rally
] call EFUNC(cba_statemachine,addTransition));

_business
