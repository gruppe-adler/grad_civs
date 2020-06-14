#include "..\script_component.hpp"

private _emotions = [] call CBA_statemachine_fnc_create;

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
] call EFUNC(cba_statemachine,addState);;

private _emo_wary = [
    _emotions,
    {
    },
    {
    },
    {
    },
    "emo_wary"
] call EFUNC(cba_statemachine,addState);;

private _emo_panic = [
    _emotions,
    {},
    {
        ["grad_civs_panicking", [_this], [_this]] call CBA_fnc_targetEvent;
    },
    {
        ["grad_civs_panicking_end", [_this], [_this]] call CBA_fnc_targetEvent;
    },
    "emo_panic"
] call EFUNC(cba_statemachine,addState);;


    // TRANSITIONS


assert ([
    _emotions,
    _emo_panic, _emo_wary,
    {
        private _cooldown = _this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60];
        private _timeUntilCooldown = _thisStateTime + _cooldown - CBA_missionTime;

        [_this, format["%1 seconds until cooldown", round _timeUntilCooldown]] call FUNC(setCurrentlyThinking);
        _timeUntilCooldown <= 0
    },
    {
        _this call FUNC(forceEmotionSpeed);
    },
    _emo_panic + _emo_wary
] call EFUNC(cba_statemachine,addTransition));


assert ([
    _emotions,
    _emo_wary, _emo_relaxed,
    {
        private _cooldown = _this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60];
        private _timeUntilCooldown = _thisStateTime + _cooldown - CBA_missionTime;

        [_this, format["%1 seconds until cooldown", round _timeUntilCooldown]] call FUNC(setCurrentlyThinking);
        _timeUntilCooldown <= 0
    },
    {
        _this call FUNC(forceEmotionSpeed);
    },
    _emo_wary + _emo_relaxed
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _emotions,
    _emo_relaxed, _emo_panic,
    ["fired_near"],
    {true},
    {},
    _emo_relaxed + _emo_panic
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _emotions,
    _emo_wary, _emo_panic,
    ["fired_near"],
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

EGVAR(common,stateMachines) setVariable ["emotions", _emotions];



_emotions
