/*
 everything the civs want to do in their day-to-day life
*/

private _business = [[], true] call CBA_statemachine_fnc_create;

// entry point
private _bus_rally  = [
    _business,
    { _this call grad_civs_fnc_sm_business_state_rally_loop },
    { _this call grad_civs_fnc_sm_business_state_rally_enter },
    { },
    "bus_rally"
] call grad_civs_fnc_addState;

/**
 * most simple thing to do: go on patrol. yay!
 */
private _bus_patrol  = [
    _business,
    {},
    { _this call grad_civs_fnc_sm_business_state_patrol_enter },
    { _this call grad_civs_fnc_sm_business_state_patrol_exit },
     "bus_patrol"
] call grad_civs_fnc_addState;


/**
 * part of the voyage cycle: mount up, voyage, dismount
 */
private _bus_mountUp = [
    _business,
    {},
    { _this call grad_civs_fnc_sm_business_state_mountUp_enter },
    { _this call grad_civs_fnc_sm_business_state_mountUp_exit },
    "bus_mountUp"
] call grad_civs_fnc_addState;

private _bus_voyage  = [
    _business,
    { _this call grad_civs_fnc_sm_business_state_voyage_loop },
    { _this call grad_civs_fnc_sm_business_state_voyage_enter },
    { _this call grad_civs_fnc_sm_business_state_voyage_exit },
    "bus_voyage"
] call grad_civs_fnc_addState;

private _bus_dismount  = [
    _business,
    {},
    { _this call grad_civs_fnc_sm_business_state_dismount_enter },
    {},
    "bus_dismount"
] call grad_civs_fnc_addState;

/*
 * residence-cycle: housework, meetNeighbor, chat
 *
 *
 */
private _bus_housework = [
    _business,
    {},
    { _this call grad_civs_fnc_sm_business_state_housework_enter },
    { _this call grad_civs_fnc_sm_business_state_housework_exit },
    "bus_housework"
] call grad_civs_fnc_addState;

private _bus_meetNeighbor = [
    _business,
     { _this call grad_civs_fnc_sm_business_state_meetNeighbor_loop },
     { _this call grad_civs_fnc_sm_business_state_meetNeighbor_enter },
     { _this call grad_civs_fnc_sm_business_state_meetNeighbor_exit },
     "bus_meetNeighbor"
] call grad_civs_fnc_addState;
private _bus_chat = [
    _business,
    { _this call grad_civs_fnc_sm_business_state_chat_loop },
    { _this call grad_civs_fnc_sm_business_state_chat_enter },
    { _this call grad_civs_fnc_sm_business_state_chat_exit },
    "bus_chat"
] call grad_civs_fnc_addState;

    // TRANSITIONS housework:

assert ([
    _business,
    _bus_rally, _bus_housework,
    { _this call grad_civs_fnc_sm_business_trans_rally_housework_condition },
    {},
    _bus_rally + _bus_housework
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_housework, _bus_meetNeighbor,
    { _this call grad_civs_fnc_sm_business_trans_housework_meetNeighbor_condition },
    {},
    _bus_housework + _bus_meetNeighbor
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_meetNeighbor, _bus_chat,
    { _this call grad_civs_fnc_sm_business_trans_meetNeighbor_chat_condition },
    {},
    _bus_meetNeighbor + _bus_chat
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_chat, _bus_housework,
    { _this call grad_civs_fnc_sm_business_trans_chat_housework_condition },
    {},
    _bus_chat + _bus_housework
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_housework, _bus_housework,
    { _this call grad_civs_fnc_sm_business_trans_housework_housework_condition },
    {},
    _bus_housework + _bus_housework
] call grad_civs_fnc_addTransition);


    // TRANSITIONS patrol:

assert ([
    _business,
    _bus_rally, _bus_patrol,
    { _this call grad_civs_fnc_sm_business_trans_rally_patrol_condition },
    {},
    _bus_rally + _bus_patrol
] call grad_civs_fnc_addTransition);


    // TRANSITIONS voyage:

assert ([
    _business,
    _bus_rally, _bus_mountUp,
    { _this call grad_civs_fnc_sm_business_trans_rally_mountUp_condition },
    {},
    _bus_rally + _bus_mountUp
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_mountUp, _bus_voyage,
    { _this call grad_civs_fnc_sm_business_trans_mountUp_voyage_condition },
    {},
    _bus_mountUp + _bus_voyage
] call grad_civs_fnc_addTransition);

assert ([
    _business,
    _bus_voyage, _bus_dismount,
    { _this call grad_civs_fnc_sm_business_trans_voyage_dismount_condition },
    {
        if (!(canMove vehicle _this)) then {
            [_this, nil] call grad_civs_fnc_setGroupVehicle;
        }
    },
    _bus_voyage + _bus_dismount
] call grad_civs_fnc_addTransition);

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
    { _this call grad_civs_fnc_sm_business_trans_mountUp_dismount_condition },
    {},
    _bus_mountUp + _bus_dismount
] call grad_civs_fnc_addTransition);


assert ([
    _business,
    _bus_dismount, _bus_rally,
    { _this call grad_civs_fnc_sm_business_trans_dismount_rally_condition },
    {},
    _bus_dismount + _bus_rally
] call grad_civs_fnc_addTransition);

GRAD_CIVS_STATE_BUSINESS = _business;
GRAD_CIVS_STATEMACHINES setVariable ["business", _business];

_business
