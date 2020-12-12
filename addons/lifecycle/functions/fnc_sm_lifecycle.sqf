#include "..\script_component.hpp"

LOG("creating sm_lifecycle...");

private _lifecycle = [{GVAR(localCivs)}, true, "lifecycle"] call EFUNC(cba_statemachine,create);


TRACE_1("sm_lifecycle '%1' created", _lifecycle);

// STATES

private _lifecycle_spawn  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_spawn_enter) },
    {},
    "lfc_spawn"
] call EFUNC(cba_statemachine,addState);

TRACE_1("lifecycle state 'spawn' created %1", _lifecycle_spawn);

private _lifecycle_life  = [
    _lifecycle,
    [],
    {},
    { _this call FUNC(sm_lifecycle_state_life_enter) },
    { _this call FUNC(sm_lifecycle_state_life_exit) },
    "lfc_life"
] call EFUNC(cba_statemachine,addCompoundState);

TRACE_1("compound lifecycle state 'life' created %1", _lifecycle_life);

private _lifecycle_unconscious  = [
    _lifecycle,
    {},
    {},
    {},
    "lfc_unconscious"
] call EFUNC(cba_statemachine,addState);

TRACE_1("lifecycle state 'lfc_unconscious' created %1", _lifecycle_unconscious);

private _lifecycle_death  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_death_enter) },
    {},
    "lfc_death"
] call EFUNC(cba_statemachine,addState);

TRACE_1("lifecycle state 'lfc_death' created %1", _lifecycle_death);

private _lifecycle_despawn  = [
    _lifecycle,
    {},
    { _this call FUNC(sm_lifecycle_state_despawn_enter) },
    {},
    "lfc_despawn"
] call EFUNC(cba_statemachine,addState);

TRACE_1("lifecycle state 'lfc_despawn' created %1", _lifecycle_despawn);

// TRANSITIONS

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

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_unconscious,
    [QGVAR(unconscious)],
    {},
    {},
    _lifecycle_life + _lifecycle_unconscious
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _lifecycle,
    _lifecycle_unconscious, _lifecycle_life,
    [QGVAR(conscious)],
    {},
    {},
    _lifecycle_unconscious + _lifecycle_life
] call CBA_statemachine_fnc_addEventTransition);

EGVAR(common,stateMachines) setVariable ["lifecycle", _lifecycle];

_lifecycle
