#include "..\script_component.hpp"

ISNILS(GVAR(showSpawnAttempts_handlers), createHashMap);
ISNILS(GVAR(showSpawnAttempts_markers), createHashMap);

if (!GVAR(showSpawnAttempts)) exitWith {
    {
        [_x, _y] call CBA_fnc_removeEventHandler;
    } forEach GVAR(showSpawnAttempts_handlers);
    GVAR(showSpawnAttempts_handlers) = createHashMap;
};

private _evtId;

_evtId = [
    QEGVAR(lifecycle,spawnRefpos),
    {
        _this params [
            ["_refPos", [], [[]]]
        ];


        private _r = [_refPos, "spawn_refpos"] call FUNC(tempMarker);
        _r setMarkerTypeLocal "hd_unknown";

        GVAR(showSpawnAttempts_markers) set [_refPos, [_r, ""]];
        [
            {
                params ["_refPos"]
                GVAR(showSpawnAttempts_markers) deleteAt _refPos
            },
            [_refPos],
            30
        ] call CBA_fnc_waitAndExecute;
    }
] call CBA_fnc_addEventHandler;
GVAR(showSpawnAttempts_handlers) set [QEGVAR(lifecycle,spawnRefpos), _evtId];

_evtId = [
    QEGVAR(lifecycle,spawnCandidate),
    {
        _this params [
            ["_refPos", [], [[]]],
            ["_candidate", objNull, [objNull]]
        ];

        private _markers = GVAR(showSpawnAttempts_markers) getOrDefault [_refPos, []];
        if (_markers isEqualTo []) exitWith {
            ERROR_1("got spawnCandidate event with unknownh refPos %1", _refPos);
        };
        private _c = "";
        if (isNull _candidate) exitWith {
            (_markers#0) setMarkerColorLocal "ColorRed";
        };

        (_markers#0) setMarkerColorLocal "ColorGrey";
        _c = [getPos _candidate, "spawn_candidate"] call FUNC(tempMarker);
        _c setMarkerTypeLocal "hd_start";
        _markers set [1, _c];
    }
] call CBA_fnc_addEventHandler;
GVAR(showSpawnAttempts_handlers) set [QEGVAR(lifecycle,spawnCandidate), _evtId];

_evtId = [
    QEGVAR(lifecycle,spawnCandidateMinDistance),
    {
        _this params [
            ["_refPos", [], [[]]],
            ["_candidate", objNull, [objNull]],
            ["_minDistanceIsGiven", false, [false]]
        ];
        private _markers = GVAR(showSpawnAttempts_markers) getOrDefault [_refPos, []];
        if (count _markers < 2) exitWith {
            ERROR_1("got spawnCandidateMinDistance event where unknown candidate (refpos %1, candidate %2)", _refPos, _candidate);
        };

        if (_minDistanceIsGiven) then {
            (_markers#1) setMarkerColorLocal "ColorYellow";
        } else {
            (_markers#1) setMarkerColorLocal "ColorRed";
        };
    }
] call CBA_fnc_addEventHandler;
GVAR(showSpawnAttempts_handlers) set [QEGVAR(lifecycle,spawnCandidateMinDistance), _evtId];

_evtId = [
    QEGVAR(lifecycle,spawnCandidatePopzone),
    {
        _this params [
            ["_refPos", [], [[]]],
            ["_candidate", objNull, [objNull]]
        ];


        private _markers = GVAR(showSpawnAttempts_markers) getOrDefault [_refPos, []];

        (_markers#1) setMarkerColorLocal "ColorGreen";
    }
] call CBA_fnc_addEventHandler;
GVAR(showSpawnAttempts_handlers) set [QEGVAR(lifecycle,spawnCandidatePopzone), _evtId];
