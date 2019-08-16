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
grad_civs_mainLoop = [_mainLoop, 2, []] call CBA_fnc_addPerFrameHandler;

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
            !(isNull _x)
        }
    },
    5,
    []
] call CBA_fnc_addPerFrameHandler;

/*
 * in case acex rebalancing moves civs to a headless client, take care to grab them
 */
if (!hasInterface && !isDedicated) then {
    [
        {
            private _allCivs = entities GRAD_CIVS_CIVCLASS;
            private _myCivs = _allCivs select { local _x && (_x getVariable ["grad_civs_primaryTask", ""] != "")};
            private _orphanedCivs = _myCivs - GRAD_CIVS_LOCAL_CIVS;
            INFO_1("%1 orphaned civs - putting them into my own array", count _orphanedCivs);
            GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS + _orphanedCivs;
        },
        30,
        []
    ] call CBA_fnc_addPerFrameHandler;
};
