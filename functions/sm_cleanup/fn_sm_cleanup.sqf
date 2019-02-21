private _cleanup = [{GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS}, true] call CBA_statemachine_fnc_create;

private _cleanup_init  = [
    _cleanup,
    {},
    {},
    {},
    "init"
] call CBA_statemachine_fnc_addState;

private _cleanup_despawn  = [
    _cleanup,
    {},
    { _this call grad_civs_fnc_sm_cleanup_state_despawn_enter },
    {},
    "despawn"
] call CBA_statemachine_fnc_addState;


assert ([
    _cleanup,
    _cleanup_init, _cleanup_despawn,
    { _this call grad_civs_fnc_sm_cleanup_trans_init_despawn_condition },
    {},
    _cleanup_init + _cleanup_despawn
] call CBA_statemachine_fnc_addTransition);
