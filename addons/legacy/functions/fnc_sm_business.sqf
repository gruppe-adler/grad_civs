#include "..\script_component.hpp"

private _business = [[], true] call CBA_statemachine_fnc_create;

// entry point
private _bus_rally  = [
    _business,
    { _this call FUNC(sm_business_state_rally_loop) },
    { _this call FUNC(sm_business_state_rally_enter) },
    { },
    "bus_rally"
] call EFUNC(cba_statemachine,addState);;

EGVAR(common,stateMachines) setVariable ["business", _business];



_business
