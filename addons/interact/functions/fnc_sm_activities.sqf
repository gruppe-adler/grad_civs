#include "..\script_component.hpp"


params [
    ["_activities", locationNull, [locationNull]]
];
assert(!(isNull _activities));

private _act_business = "act_business";
private _act_panic = "act_panic";

private _act_surrendered = [
    _activities,
    {},
    { _this call FUNC(sm_activities_state_surrendered_enter) },
    { _this call FUNC(sm_activities_state_surrendered_exit) },
    "act_surrendered"
] call EFUNC(cba_statemachine,addState);
assert(_act_surrendered != "");

// TRANSITIONS

assert ([
    _activities,
    _act_business, _act_surrendered,
    { _this call FUNC(sm_activities_trans_business_surrendered_condition) },
    {},
    _act_business + _act_surrendered
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_surrendered, _act_business,
    { _this call FUNC(sm_activities_trans_surrendered_business_condition) },
    {},
    _act_surrendered + _act_business
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_surrendered, _act_panic,
    { _this call FUNC(sm_activities_trans_surrendered_panic_condition) },
    {},
    _act_surrendered + _act_panic
] call EFUNC(cba_statemachine,addTransition));
