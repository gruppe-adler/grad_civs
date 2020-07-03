#include "..\script_component.hpp"

params [
    ["_business", locationNull, [locationNull]]
];
assert(!(isNull _business));

private _bus_rally = "bus_rally";
/**
 * most simple thing to do: go on patrol. yay!
 */
private _bus_patrol  = [
    _business,
    {},
    { _this call FUNC(sm_business_state_patrol_enter) },
    { _this call FUNC(sm_business_state_patrol_exit) },
     QUOTE(bus_patrol)
] call EFUNC(cba_statemachine,addState);;


    // TRANSITIONS patrol:

assert ([
    _business,
    _bus_rally, _bus_patrol,
    { _this call FUNC(sm_business_trans_rally_patrol_condition) },
    {},
    _bus_rally + _bus_patrol
] call EFUNC(cba_statemachine,addTransition));

_business
