#include "..\script_component.hpp"

params [
    ["_civ", objNull],
    ["_reverseTargetPos", [0, 0, 0]]
];

if (isNull _civ) exitWith {
    ERROR("doReverse target was null!");
};

if (!(local _civ)) exitWith { // if not local, fix by deferring
    [
        QGVAR(doReverse),
        [_civ, _reverseTargetPos],
        _civ
    ] call CBA_fnc_targetEvent;
};

if (_civ == (call CBA_fnc_currentUnit)) exitWith {};

private _veh = vehicle _civ;
if (_veh isEqualTo _civ) exitWith {
    ERROR_1("civ %1 was told to reverse while not being mounted");
};

[
    _civ,
    {
        params [
            ["_civ", objNull, [objNull]],
            ["_reverseTargetPos", [0, 0, 0], [[]]],
            ["_doTrueReverse", true, [true]]
        ];
        private _group = group driver vehicle _civ;
        INFO_1("civ %1 is being sent away with vehicle. removing pre-existing waypoints", _civ);
        [_group] call CBA_fnc_clearWaypoints;

        if (_doTrueReverse) then {
            [
                vehicle _civ,
                _reverseTargetPos,
                60,
                {}
            ] call FUNC(reverse);

            INFO_2("vehicle %1 reverses to %2 and then waits", _civ, _reverseTargetPos);
        } else {
            INFO_2("vehicle %1 is moving back to %2 and then waits", _civ, _reverseTargetPos);
            _civ doMove _reverseTargetPos;
        };
    },
    {
        params [
            ["_civ", objNull, [objNull]],
            ["_reverseTargetPos", [0, 0, 0], [[]]],
            ["_doTrueReverse", true, [true]]
        ];
        if (_doTrueReverse) then {
            [vehicle _civ] call FUNC(reverse_abort);
        };
    },
    { // wait for players to go away
        params [
            ["_civ", objNull, [objNull]]
        ];
        [ALL_HUMAN_PLAYERS, getPos _civ, 200] call EFUNC(lifecycle,isInDistanceFromOtherPlayers);
    },
    [
        +_reverseTargetPos,
        count (fullCrew [_veh, "", true]) > 1 // NOTE: driving in reverse needs a vehiclecommander, cannot be done with a single-seater
    ],
    "reversing",
    "sent away. reversing, then doing nothing until players have left"
] call FUNC(doCustomActivity);
