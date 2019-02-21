
private _activities = [{GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS}, true] call CBA_statemachine_fnc_create;

// STATES

private _act_init  = [
    _activities,
    {},
    {},
    {},
    "act_init"
] call CBA_statemachine_fnc_addState;

private _act_flight  = [
    _activities,
    { _this call grad_civs_fnc_sm_activities_state_flight_loop },
    { _this call grad_civs_fnc_sm_activities_state_flight_enter },
    { _this call grad_civs_fnc_sm_activities_state_flight_exit },
    "act_flight"
] call CBA_statemachine_fnc_addState;

private _act_hide  = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_hide_enter },
    { _this call grad_civs_fnc_sm_activities_state_hide_exit },
    "act_hide"
] call CBA_statemachine_fnc_addState;


private _act_asOrdered  = [
    _activities,
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_loop },
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_enter },
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_exit },
    "act_asOrdered"
] call CBA_statemachine_fnc_addState;


// NOTE concerning act_hidden and act_surrendered
// both states need the unit to be stopped, and to *not* move during the transition between both of them
// hence, I put the `_this stop <boolean>` into the *transitions* into and from the hidden/surrender node cluster
private _act_hidden  = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_hidden_enter },
    {},
    "act_hidden"
] call CBA_statemachine_fnc_addState;

private _act_patrol  = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_patrol_enter },
    { _this call grad_civs_fnc_sm_activities_state_patrol_exit },
     "act_patrol"
] call CBA_statemachine_fnc_addState;

private _act_rally  = [
    _activities,
    { _this call grad_civs_fnc_sm_activities_state_rally_loop },
    { _this call grad_civs_fnc_sm_activities_state_rally_enter },
    {},
    "act_rally"
] call CBA_statemachine_fnc_addState;

private _act_surrendered = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_surrendered_enter },
    { _this call grad_civs_fnc_sm_activities_state_surrendered_exit },
    "act_surrendered"
] call CBA_statemachine_fnc_addState;

private _act_mountUp = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_mountUp_enter },
    { _this call grad_civs_fnc_sm_activities_state_mountUp_exit },
    "act_mountUp"
] call CBA_statemachine_fnc_addState;

private _act_voyage  = [
    _activities,
    { _this call grad_civs_fnc_sm_activities_state_voyage_loop },
    { _this call grad_civs_fnc_sm_activities_state_voyage_enter },
    { _this call grad_civs_fnc_sm_activities_state_voyage_exit },
    "act_voyage"
] call CBA_statemachine_fnc_addState;

private _act_dismount  = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_dismount_enter },
    { },
    "act_dismount"
] call CBA_statemachine_fnc_addState;


// TRANSITIONS


assert ([_activities, _act_init, _act_rally, {true}, {}, _act_init + _act_rally] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_rally, _act_patrol,
    { _this call grad_civs_fnc_sm_activities_trans_rally_patrol_condition },
    {},
    _act_rally + _act_patrol
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_rally, _act_mountUp,
    { _this call grad_civs_fnc_sm_activities_trans_rally_mountUp_condition },
    {},
    _act_rally + _act_mountUp
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_mountUp, _act_voyage,
    { _this call grad_civs_fnc_sm_activities_trans_mountUp_voyage_condition },
    {},
    _act_mountUp + _act_voyage
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_hide, _act_hidden,
    { _this call grad_civs_fnc_sm_activities_trans_hide_hidden_condition },
    { _this call grad_civs_fnc_sm_activities_trans_hide_hidden_handler },
    _act_hide + _act_hidden
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_flight, _act_hide,
    {
        (CBA_missionTime - (_this getVariable ["grad_civ_hidetime", CBA_missionTime])) > 0
    },
    {},
    _act_flight + _act_hide
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_voyage, _act_dismount,
    {
        (_this call grad_civs_fnc_sm_activities_helper_surrenderCondition) || !(canMove vehicle _this)
    },
    {
        if (!(canMove vehicle _this)) then {
            [_this, nil] call grad_civs_fnc_setGroupVehicle;
        }
    },
    _act_voyage + _act_dismount
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_mountUp, _act_dismount,
    { _this call grad_civs_fnc_sm_activities_helper_surrenderCondition },
    {},
    _act_mountUp + _act_dismount
] call CBA_statemachine_fnc_addTransition);

// surrenders:
assert ([
    _activities,
    _act_dismount, _act_surrendered,
    { _this call grad_civs_fnc_sm_activities_trans_dismount_surrendered_condition },
    {},
    _act_dismount + _act_surrendered
] call CBA_statemachine_fnc_addTransition);

// TODO the surrender stuff is so common, it should be an event transition (plus helper condition)
// or even a transition into a different state machine? not sure, those transitions may be rough around the edges
assert ([_activities, _act_hidden, _act_surrendered, { _this call grad_civs_fnc_sm_activities_helper_surrenderCondition }, {}, _act_hidden + _act_surrendered] call CBA_statemachine_fnc_addTransition);
assert ([_activities, _act_rally, _act_surrendered, { _this call grad_civs_fnc_sm_activities_helper_surrenderCondition }, {}, _act_rally + _act_surrendered] call CBA_statemachine_fnc_addTransition);
assert ([_activities, _act_patrol, _act_surrendered, { _this call grad_civs_fnc_sm_activities_helper_surrenderCondition }, {}, _act_patrol + _act_surrendered] call CBA_statemachine_fnc_addTransition);
assert ([
    _activities,
    _act_dismount, _act_flight,
    { _this call grad_civs_fnc_sm_activities_trans_dismount_flight_condition },
    {},
    _act_dismount + _act_flight
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_mountUp, _act_flight,
    { _this call grad_civs_fnc_sm_activities_trans_dismount_flight_condition },
    {},
    _act_mountUp + _act_flight
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_dismount, _act_rally,
    { _this call grad_civs_fnc_sm_activities_trans_dismount_rally_condition },
    {},
    _act_dismount + _act_rally
] call CBA_statemachine_fnc_addTransition);

// free:
assert ([
    _activities,
    _act_surrendered, _act_rally,
    { _this call grad_civs_fnc_sm_activities_trans_surrendered_rally_condition },
    {},
    _act_surrendered + _act_rally
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_surrendered, _act_hide,
    { _this call grad_civs_fnc_sm_activities_trans_surrendered_hide_condition },
    {},
    _act_surrendered + _act_hide
] call CBA_statemachine_fnc_addTransition);


// flight (event transitions):
// assert ([_activities, _act_surrendered, _act_flight, ["fired_near"], {true}, {}, _act_surrendered + _act_flight] call CBA_statemachine_fnc_addEventTransition); // dont let that happen for now
assert ([_activities, _act_patrol, _act_flight, ["grad_civ_panicking"], {true}, {}, _act_patrol + _act_flight] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_rally, _act_flight, ["grad_civ_panicking"], {true}, {}, _act_rally + _act_flight] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_voyage, _act_dismount, ["grad_civ_panicking"], {true}, {}, _act_voyage + _act_dismount] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_asOrdered, _act_dismount, ["grad_civ_panicking"], {true}, {}, _act_asOrdered + _act_flight] call CBA_statemachine_fnc_addEventTransition);

assert ([_activities, _act_flight, _act_rally, ["grad_civ_panicking_end"], {true}, {}, _act_flight + _act_rally] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_hide, _act_rally, ["grad_civ_panicking_end"], {true}, {}, _act_hide + _act_rally] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_hidden, _act_rally, ["grad_civ_panicking_end"], {true}, { _this call grad_civs_fnc_sm_activities_trans_hidden_rally_handler }, _act_hidden + _act_rally] call CBA_statemachine_fnc_addEventTransition);

assert ([_activities, _act_rally, _act_asOrdered, ["ace_interaction_getDown", "ace_interaction_sendAway"], {true}, {}, _act_rally + _act_asOrdered] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_patrol, _act_asOrdered, ["ace_interaction_getDown", "ace_interaction_sendAway"], {true}, {}, _act_patrol + _act_asOrdered] call CBA_statemachine_fnc_addEventTransition);
assert ([_activities, _act_surrendered, _act_asOrdered, ["ace_interaction_getDown", "ace_interaction_sendAway"], {true}, {}, _act_surrendered + _act_asOrdered] call CBA_statemachine_fnc_addEventTransition);

assert ([_activities, _act_asOrdered, _act_rally, { _this call grad_civs_fnc_sm_activities_trans_asOrdered_rally_condition }, {}, _act_asOrdered + _act_rally] call CBA_statemachine_fnc_addTransition);

GRAD_CIVS_STATE_ACTIVITIES = _activities;
