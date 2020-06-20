#include "..\script_component.hpp"

private _lifecycle = [{GVAR(localCivs)}, true] call CBA_statemachine_fnc_create;

private _activities = [] call FUNC(sm_activities);
private _emotions = [] call FUNC(sm_emotions);

private _lifecycle_spawn  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_spawn_enter) },
    {},
    "lfc_spawn"
] call EFUNC(cba_statemachine,addState);;

private _lifecycle_life  = [
    _lifecycle,
    [_activities, _emotions],
    {},
    {  _this call FUNC(sm_lifecycle_state_life_enter) },
    { _this call FUNC(sm_lifecycle_state_life_exit) },
    "lfc_life"
] call EFUNC(cba_statemachine,addCompoundState);;

private _lifecycle_death  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_death_enter) },
    {},
    "lfc_death"
] call EFUNC(cba_statemachine,addState);;

private _lifecycle_despawn  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_despawn_enter) },
    {},
    "lfc_despawn"
] call EFUNC(cba_statemachine,addState);;

assert ([
    _lifecycle,
    _lifecycle_spawn, _lifecycle_life,
    {  true },
    { },
    _lifecycle_spawn + _lifecycle_life
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_despawn,
    { _this call FUNC(sm_lifecycle_trans_life_despawn_condition) },
    {},
    _lifecycle_life + _lifecycle_despawn
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_death,
    ["killed"],
    { true },
    {},
    _lifecycle_life + _lifecycle_death
] call CBA_statemachine_fnc_addEventTransition);

EGVAR(common,stateMachines) setVariable ["lifecycle", _lifecycle];

_lifecycle
