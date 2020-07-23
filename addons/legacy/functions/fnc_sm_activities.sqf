#include "..\script_component.hpp"

private _activities = [[], true] call CBA_statemachine_fnc_create;
private _business = [] call FUNC(sm_business);
private _panic = [] call FUNC(sm_panic);

[QEGVAR(common,pointed_at_inc), {
    params ["_civ"];
    if (_civ == ACE_player) exitWith {};
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount + 1];
}] call CBA_fnc_addEventHandler;

[QEGVAR(common,pointed_at_dec), {
    params ["_civ"];
    if (_civ == ACE_player) exitWith {};
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    assert(_currentCount > 0);
    if (_currentCount < 1) then {_currentCount = 1;};
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount - 1, true];
}] call CBA_fnc_addEventHandler;


[
    "ace_interaction_getDown",
    {
        params [
            ["_target", objNull]
        ];
        INFO_1("civ %1 is being sent down", _target);

        private _recklessness = _target getVariable ["grad_civs_recklessness", 5];
        private _waitTime = linearConversion [0, 10, _recklessness, 3600, 180, false];
        [
            _target,
            {},
            {
                params ["_target"];
                [_target, ""] call FUNC(setCurrentlyThinking);
            },
            _waitTime,
            [],
            "ace_interaction_getDown",
            format["I will keep my head down until %1", _waitTime call FUNC(formatNowPlusSeconds)]
        ] call FUNC(doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[
    "ace_interaction_sendAway",
    {
        params [
            ["_target", objNull],
            ["_pos", [0, 0, 0]]
        ];
        INFO_2("civ %1 is being sent away to %2", _target, _pos);
        private _recklessness = _target getVariable ["grad_civs_recklessness", 5];
        private _waitTime = linearConversion [0, 10, _recklessness, 60, 5, false];
        [
            _target,
            {
            },
            {},
            _waitTime,
            [],
            "ace_interaction_sendAway",
            format["am being sent away to %1, will resume activity at %2", _pos, _waitTime call FUNC(formatNowPlusSeconds)]
        ] call FUNC(doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[
    "honked_at",
    {
        params [
            ["_target", objNull],
            ["_carPos", [0, 0, 0]],
            ["_carVelocity", [0, 0, 0]]
        ];
        if (_target == ACE_player) exitWith {};
        INFO_1("civ %1 is being honked at", _target);

        private _recklessness = _target getVariable ["grad_civs_recklessness", 5];
        private _waitTime = linearConversion [0, 10, _recklessness, 15, 1, false];

        [
            _target,
            {
                params ["_target", "_carPos", "_carVelocity"];

                private _moveVectors = [
                    [-(_carVelocity select 1), _carVelocity select 0, _carPos select 2],
                    [_carVelocity select 1, -(_carVelocity select 0),  _carPos select 2]
                ];
                // go left or right, depending on where to get further from the vehicle
                private _moveVector = _moveVectors select 0;
                if ((_moveVector distance _carPos) > ((_moveVectors select 1) distance _carPos)) then {
                    _moveVector = _moveVectors select 1;
                };
                _civ call FUNC(forcePanicSpeed);
                _civ doMove ((position _civ) vectorAdd _moveVector);
            },
            {},
            _waitTime,
            [_carPos, _carVelocity],
            "honked_at",
            format["am avoiding honking car, will resume activity at %1", _waitTime call FUNC(formatNowPlusSeconds)]
        ] call FUNC(doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[QGVAR(gestured_at_vehicle_go), {
    params [
        ["_target", objNull],
        ["_vectorDir", [0, 0, 0]]
    ];
    if (_target == ACE_player) exitWith {};
    if (_vectorDir isEqualTo [0, 0, 0]) exitWith {
        WARNING_1("inconclusive 'go' gesture, %1 will do nothing", _target);
    };

    private _reverseTargetPos = (getPos _target) vectorAdd (_vectorDir vectorMultiply 50);

    [_target, _reverseTargetPos] call FUNC(customActivity_reverse);
}] call CBA_fnc_addEventHandler;

[QGVAR(told_to_reverse), {
    params [
        ["_target", objNull, [objNull]],
        ["_reverseTargetPos", [0, 0, 0], [[]]]
    ];
    [_target, _reverseTargetPos] call FUNC(customActivity_reverse);
}] call CBA_fnc_addEventHandler;

// STATES
assert(_activities isEqualType locationNull);
assert(_business isEqualType locationNull);
assert(_panic isEqualType locationNull);

private _act_business = [
    _activities,
    [_business],
    {},
    {},
    {},
    "act_business"
] call EFUNC(cba_statemachine,addCompoundState);
assert(_act_business != "");

private _act_asOrdered = [
    _activities,
    {},
    { _this call FUNC(sm_activities_state_asOrdered_enter) },
    { _this call FUNC(sm_activities_state_asOrdered_exit) },
    "act_asOrdered"
] call EFUNC(cba_statemachine,addState);
assert(_act_asOrdered != "");

private _act_surrendered = [
    _activities,
    {},
    { _this call FUNC(sm_activities_state_surrendered_enter) },
    { _this call FUNC(sm_activities_state_surrendered_exit) },
    "act_surrendered"
] call EFUNC(cba_statemachine,addState);
assert(_act_surrendered != "");

private _act_panic = [
    _activities,
    [_panic],
    {  },
    { _this call FUNC(sm_activities_state_panic_enter) },
    { _this call FUNC(sm_activities_state_panic_exit) },
    "act_panic"
] call EFUNC(cba_statemachine,addCompoundState);
assert(_act_panic != "");

// TRANSITIONS

assert ([
    _activities,
    _act_business, _act_surrendered,
    { _this call FUNC(sm_activities_trans_business_surrendered_condition) },
    {},
    _act_business + _act_surrendered
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_business, _act_panic,
    { _this call FUNC(sm_activities_trans_business_panic_condition) },
    {},
    _act_business + _act_panic
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_surrendered, _act_business,
    { _this call FUNC(sm_activities_trans_surrendered_business_condition) },
    {},
    _act_surrendered + _act_business
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_surrendered, _act_panic,
    { _this call FUNC(sm_activities_trans_surrendered_panic_condition) },
    {},
    _act_surrendered + _act_panic
] call EFUNC(cba_statemachine,addTransition));

assert ([
    _activities,
    _act_panic, _act_business,
    ["grad_civs_panicking_end"],
    {true},
    {[QGVAR(switchMove), [_this, ""]] call CBA_fnc_globalEvent;},
    _act_panic + _act_business
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _activities,
    _act_business, _act_asOrdered,
    [QGVAR(customActivity_start)],
    {true},
    {},
    _act_business + _act_asOrdered
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _activities,
    _act_asOrdered, _act_business,
    [QGVAR(customActivity_end)],
    {true},
    {},
    _act_asOrdered + _act_business + "_event"
] call CBA_statemachine_fnc_addEventTransition);

EGVAR(common,stateMachines) setVariable ["activities", _activities];



_activities
