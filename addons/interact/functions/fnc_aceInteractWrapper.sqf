#include "..\script_component.hpp"

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
                [_target, ""] call EFUNC(legacy,setCurrentlyThinking);
            },
            _waitTime,
            [],
            "ace_interaction_getDown",
            format["I will keep my head down until %1", _waitTime call EFUNC(common,formatNowPlusSeconds)]
        ] call EFUNC(legacy,doCustomActivity);
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
            format["am being sent away to %1, will resume activity at %2", _pos, _waitTime call EFUNC(common,formatNowPlusSeconds)]
        ] call EFUNC(legacy,doCustomActivity);
    }
] call CBA_fnc_addEventHandler;
