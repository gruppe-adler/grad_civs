#include "..\..\component.hpp"

ASSERT_SERVER("");

if (!GRAD_CIVS_ENABLEDINVEHICLES && !GRAD_CIVS_ENABLEDONFOOT) exitWith {-1};

private _mainLoop = {
    params ["_args", "_handle"];

    if (call GRAD_CIVS_EXITON) exitWith {
        INFO("exiting because GRAD_CIVS_EXITON returned true");
        [_handle] call CBA_fnc_removePerFrameHandler
    };
    if (isDedicated && (count ((entities "HeadlessClient_F") arrayIntersect allPlayers) > 0)) exitWith {
        INFO("HCs are taking over, will not spawn any more civs");
        [_handle] call CBA_fnc_removePerFrameHandler
    };

    [] call grad_civs_fnc_spawnPass;
};

// wait a bit until the main loop starts. that way, exclusion zone trigger inits have a chance to run
[
    {
        private _mainLoop = _this#0;
        grad_civs_mainLoop = [_mainLoop, 2, []] call CBA_fnc_addPerFrameHandler;
    },
    [_mainLoop],
    10
] call CBA_fnc_waitAndExecute;


grad_civs_debugLoop = [{
    params ["_args", "_handle"];
    if (call GRAD_CIVS_EXITON) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
    if (GRAD_CIVS_DEBUG_CIVSTATE) then {
        { _x call grad_civs_fnc_updateInfoLine; } forEach GRAD_CIVS_LOCAL_CIVS;
    };
}, 0.1, []] call CBA_fnc_addPerFrameHandler;


[
    {
        if (GRAD_CIVS_DEBUG_FPS) then {
            ["server_fps", [clientOwner, diag_fps]] call CBA_fnc_globalEvent;
        };
    },
    2,
    []
] call CBA_fnc_addPerFrameHandler;

// clean up objNull references in civs array - that happens for example when a zeus person deletes them
[
    {
        GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS select {
            if (isNull _x) then {
                INFO_1("abandoning civilian they have become NULL (deleted?)", _x);
                false
            } else {
                if (local _x) then {
                    true
                } else {
                    WARNING_1("abandoning civilian %1 as they are not local any more", _x);
                    false
                };
            };
        };
    },
    5,
    []
] call CBA_fnc_addPerFrameHandler;

/*
 * if a civ gets moved to the HC for some reason (for example by  acex_headless) take care to grab them
 */
if (!hasInterface && !isDedicated) then {
    [
        {
            private _allCivs = entities GVAR(CIVCLASS);
            private _myCivs = _allCivs select { local _x && (_x getVariable ["grad_civs_primaryTask", ""] != "")};
            private _orphanedCivs = _myCivs - GRAD_CIVS_LOCAL_CIVS;
            INFO_1("%1 orphaned civs - putting them into my own array", count _orphanedCivs);
            GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS + _orphanedCivs;
        },
        30,
        []
    ] call CBA_fnc_addPerFrameHandler;
};
