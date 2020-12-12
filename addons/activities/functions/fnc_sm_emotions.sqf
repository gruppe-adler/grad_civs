#include "..\script_component.hpp"

params [
    ["_sm_lifecycle", locationNull, [locationNull]]
];


private _emotions = [[], true, "emotions"] call EFUNC(cba_statemachine,create);

// STATES

private _emo_relaxed = [
    _emotions,
    {
    },
    {
    },
    {
    },
    "emo_relaxed"
] call EFUNC(cba_statemachine,addState);

private _emo_wary = [
    _emotions,
    {
    },
    {
        _this call FUNC(forceEmotionSpeed);

        private _cooldownAt = (_this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60]) + CBA_missionTime;
        _this setVariable [QGVAR(cooldownAt), _cooldownAt];
    },
    {
    },
    "emo_wary"
] call EFUNC(cba_statemachine,addState);

private _emo_panic = [
    _emotions,
    {},
    {
        _this call FUNC(endCustomActivity);
        _this call FUNC(forceEmotionSpeed);

        private _cooldownAt = (_this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60]) + CBA_missionTime;
        _this setVariable [QGVAR(cooldownAt), _cooldownAt];

        ["grad_civs_panicking", [_this], [_this]] call CBA_fnc_targetEvent;
    },
    {
        ["grad_civs_panicking_end", [_this], [_this]] call CBA_fnc_targetEvent;
    },
    "emo_panic"
] call EFUNC(cba_statemachine,addState);

// TRANSITIONS

assert ([
    _emotions,
    _emo_panic, _emo_wary,
    {(_this getVariable [QGVAR(cooldownAt), 0]) < CBA_missionTime},
    {},
    _emo_panic + _emo_wary
] call EFUNC(cba_statemachine,addTransition));


assert ([
    _emotions,
    _emo_wary, _emo_relaxed,
    {(_this getVariable [QGVAR(cooldownAt), 0]) < CBA_missionTime},
    {},
    _emo_wary + _emo_relaxed
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _emotions,
    _emo_relaxed, _emo_panic,
    [QGVAR(firedNear)],
    {true},
    {},
    _emo_relaxed + _emo_panic
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _emotions,
    _emo_wary, _emo_panic,
    [QGVAR(firedNear)],
    {true},
    {},
    _emo_wary + _emo_panic
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _emotions,
    _emo_relaxed, _emo_wary,
    ["fired_far"],
    {true},
    {},
    _emo_relaxed + _emo_wary
] call CBA_statemachine_fnc_addEventTransition);

[_sm_lifecycle, "lfc_life", _emotions] call EFUNC(cba_statemachine,addNestedStateMachine);

EGVAR(common,stateMachines) setVariable ["emotions", _emotions];

_emotions
