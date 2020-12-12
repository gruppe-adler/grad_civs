#include "..\script_component.hpp"

private _business = [[], true, "business"] call EFUNC(cba_statemachine,create);

// entry point
private _bus_rally  = [
    _business,
    { },
    { _this call FUNC(sm_business_state_rally_enter) },
    { },
    "bus_rally"
] call EFUNC(cba_statemachine,addState);

EGVAR(common,stateMachines) setVariable ["business", _business];

_business
