#include "..\script_component.hpp"
#define EXITIFLOCALPLAYER(t) if (t == (call CBA_fnc_currentUnit)) exitWith {}

[QGVAR(pointed_at_inc), {
    params ["_civ", "_pointingPlayer"];
    EXITIFLOCALPLAYER(_civ);
    private _currentCount = _civ getVariable [QGVAR(pointedAtCount), 0];
    _civ setVariable [QGVAR(pointedAtCount), _currentCount + 1, true];
    _civ setVariable [QGVAR(pointingPlayer), _pointingPlayer]; // local is enough, used for immediate effect
}] call CBA_fnc_addEventHandler;

[QGVAR(pointed_at_dec), {
    params ["_civ"];
    EXITIFLOCALPLAYER(_civ);
    private _currentCount = _civ getVariable [QGVAR(pointedAtCount), 0];
    assert(_currentCount > 0);
    if (_currentCount < 1) then {_currentCount = 1;};
    _civ setVariable [QGVAR(pointedAtCount), _currentCount - 1, true];
}] call CBA_fnc_addEventHandler;

[
    QGVAR(honked_at),
    {
        params [
            ["_target", objNull],
            ["_carPos", [0, 0, 0]],
            ["_carVelocity", [0, 0, 0]]
        ];
        EXITIFLOCALPLAYER(_target);
        INFO_1("civ %1 is being honked at", _target);

        private _recklessness = _target getVariable ["grad_civs_recklessness", 5];
        private _waitTime = linearConversion [0, 10, _recklessness, 15, 1, false];

        [
            _target,
            {
                params [
                    ["_target", objNull, [objNull]],
                    ["_carPos", [0, 0, 0], [[]]],
                    ["_carVelocity", [0, 0, 0], [[]]]
                ];
                private _civPos = getPos _target;
                private _moveVectors = [
                    [-(_carVelocity#1), _carVelocity#0, 0],
                    [_carVelocity#1, -(_carVelocity#0),  0]
                ];
                // go left or right, depending on where to get further from the vehicle
                private _moveVector = _moveVectors#0;
                if (((_moveVectors#0 vectorAdd _civPos) distance _carPos) < ((_moveVectors#1 vectorAdd _civPos) distance _carPos)) then {
                    _moveVector = _moveVectors#1;
                };
                _civ call EFUNC(activities,forcePanicSpeed);
                _civ doMove ((position _civ) vectorAdd _moveVector);
            },
            {},
            _waitTime,
            [_carPos, _carVelocity],
            "honked_at",
            format["am avoiding honking car, will resume activity at %1", _waitTime call EFUNC(common,formatNowPlusSeconds)]
        ] call EFUNC(activities,doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(flown_over),
    {
        params [
            ["_target", objNull],
            ["_carPos", [0, 0, 0]],
            ["_carVelocity", [0, 0, 0]]
        ];
        EXITIFLOCALPLAYER(_target);
        LOG_1("civ %1 is being flown over", _target);

        private _recklessness = _target getVariable ["grad_civs_recklessness", 5];
        private _waitTime = linearConversion [0, 10, _recklessness, 15, 3, false];

        if ([_target] call EFUNC(activities,doingCustomActivity)) exitWith {
            LOG_1("civ %1 : not interrupting customn activity %2", _target, [_target] call EFUNC(activities,getCustomActivity));
        }; // being flown over is _not_ interrupting, esp it should  not interrupt itself

        [
            _target,
            {
                params [
                    ["_target", objNull, [objNull]],
                    ["_carPos", [0, 0, 0], [[]]],
                    ["_carVelocity", [0, 0, 0], [[]]]
                ];
                private _minRunDist = 20;
                private _civPos = getPos _target; _civPos set [2, 0];

                private _moveVector = [0, 0, 0];
                if ((vectorMagnitude [_carVelocity#0, _carVelocity#1]) < 5) then { // decide for random direction and magnitude on low horizontal velocity
                    _moveVector = (vectorNormalized [(random 2) - 1, (random 2) - 1]) vectorMultiply _minRunDist;
                } else  {
                    private _moveVectors = [
                        [-(_carVelocity#1), _carVelocity#0, 0],
                        [_carVelocity#1, -(_carVelocity#0),  0]
                    ];
                    // go left or right, depending on where to get further from the vehicle
                    _moveVector = _moveVectors#0;
                    if (((_moveVectors#0 vectorAdd _civPos) distance _carPos) < ((_moveVectors#1 vectorAdd _civPos) distance _carPos)) then {
                        _moveVector = _moveVectors#1;
                    };
                    if ((vectorMagnitude _moveVector) < _minRunDist) then {
                         _moveVector = (vectorNormalized _moveVector) vectorMultiply _minRunDist
                    };
                };
                _target call EFUNC(activities,forcePanicSpeed);
                _target doMove (_civPos vectorAdd _moveVector vectorAdd (_carVelocity vectorMultiply (random [0, 0.5, 1])));
            },
            {
                params [["_target", objNull, [objNull]]];
                doStop _target;
            },
            _waitTime,
            [_carPos, _carVelocity],
            "flown_over",
            format["am avoiding air vehicle, will resume activity at %1", _waitTime call EFUNC(common,formatNowPlusSeconds)]
        ] call EFUNC(activities,doCustomActivity);
    }
] call CBA_fnc_addEventHandler;

[QGVAR(told_to_reverse), {
    params [
        ["_target", objNull, [objNull]],
        ["_reverseTargetPos", [0, 0, 0], [[]]]
    ];
    EXITIFLOCALPLAYER(_target);
    [_target, _reverseTargetPos] call EFUNC(activities,doReverse);
}] call CBA_fnc_addEventHandler;
