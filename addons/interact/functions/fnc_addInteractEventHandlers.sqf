#include "..\script_component.hpp"

[QGVAR(pointed_at_inc), {
    params ["_civ"];
    if (_civ == ACE_player) exitWith {};
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount + 1];
}] call CBA_fnc_addEventHandler;

[QGVAR(pointed_at_dec), {
    params ["_civ"];
    if (_civ == ACE_player) exitWith {};
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    assert(_currentCount > 0);
    if (_currentCount < 1) then {_currentCount = 1;};
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount - 1, true];
}] call CBA_fnc_addEventHandler;

[
    QGVAR(honked_at),
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
                _civ call EFUNC(legacy,forcePanicSpeed);
                _civ doMove ((position _civ) vectorAdd _moveVector);
            },
            {},
            _waitTime,
            [_carPos, _carVelocity],
            "honked_at",
            format["am avoiding honking car, will resume activity at %1", _waitTime call EFUNC(common,formatNowPlusSeconds)]
        ] call EFUNC(legacy,doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[QGVAR(told_to_reverse), {
    params [
        ["_target", objNull, [objNull]],
        ["_reverseTargetPos", [0, 0, 0], [[]]]
    ];
    [_target, _reverseTargetPos] call EFUNC(legacy,doReverse);
}] call CBA_fnc_addEventHandler;
