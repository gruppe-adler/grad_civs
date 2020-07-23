#include "..\script_component.hpp"

params [
    ["_civ", objNull],
    ["_reverseTargetPos", [0, 0, 0]]
];

[
    _civ,
    {
        params ["_civ", "_reverseTargetPos"];
        private _group = group driver vehicle _civ;
        INFO_1("civ %1 is being sent away with vehicle, remove pre-existing waypoints", _civ);

        [_group] call CBA_fnc_clearWaypoints;

        [
            vehicle _civ,
            _reverseTargetPos,
            60,
            { // onDone
                params ["_vehicle"];
                [leader group driver _vehicle, "custom activity: waiting for players to go away"] call FUNC(setCurrentlyThinking);
            }
        ] call FUNC(reverse);

        INFO_2("vehicle %1 reversing to %2 and then waiting", _civ, _reverseTargetPos);
    },
    {
        params ["_civ", ""];
        [vehicle _civ] call FUNC(reverse_abort);
    },
    { // wait for players to go away
        params ["_civ"];
        [ALL_HUMAN_PLAYERS, getPos _civ, 200] call FUNC(isInDistanceFromOtherPlayers);
    },
    [_reverseTargetPos],
    "reversing",
    "sent away. reversing, then doing nothing until players have left"
] call FUNC(doCustomActivity);
