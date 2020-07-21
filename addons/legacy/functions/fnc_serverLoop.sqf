#include "..\script_component.hpp"

ASSERT_SERVER("");

ISNILS(GVAR(EXITON), {});

private _mainLoop = {
    params ["_args", "_handle"];
    if (!isGameFocused || isGamePaused) exitWith {};

    if (call GVAR(EXITON)) exitWith {
        INFO("exiting because GRAD_CIVS_EXITON returned true");
        [_handle] call CBA_fnc_removePerFrameHandler
    };
    if (isDedicated && (count ((entities "HeadlessClient_F") arrayIntersect allPlayers) > 0)) exitWith {
        INFO("HCs are available, will not spawn any more civs");
        [_handle] call CBA_fnc_removePerFrameHandler
    };

    [] call FUNC(spawnPass);
};

// wait a bit until the main loop starts. that way, exclusion zone trigger inits have a chance to run
[
    {
        private _mainLoop = _this#0;
        GVAR(mainLoopHandle) = [_mainLoop, 2, []] call CBA_fnc_addPerFrameHandler;
    },
    [_mainLoop],
    10
] call CBA_fnc_waitAndExecute;


GVAR(debugLoopHandle) = [{
    params ["_args", "_handle"];
    if (!isGameFocused || isGamePaused) exitWith {};
    if (call GVAR(EXITON)) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
    if ((GVAR(debugCivState))) then {
        { _x call FUNC(updateInfoLine); } forEach GVAR(localCivs);
    };
}, 0.1, []] call CBA_fnc_addPerFrameHandler;


[
    {
        if (GVAR(debugFps)) then {
            ["server_fps", [clientOwner, diag_fps]] call CBA_fnc_globalEvent;
        };
    },
    2,
    []
] call CBA_fnc_addPerFrameHandler;

// clean up objNull references in civs array - that happens for example when a zeus person deletes them
[
    {
        GVAR(localCivs) = GVAR(localCivs) select {
            // NOTE: do not handle `alive` here, we've got a transition & state for proper disposal of dead civilians
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
            private _civClasses = call EFUNC(common,config_getCivClasses);
            private _allCivs = entities [_civClasses, [], true, true];
            private _myCivs = _allCivs select { local _x && (_x getVariable ["grad_civs_primaryTask", ""] != "")};
            private _orphanedCivs = _myCivs - GVAR(localCivs);
            INFO_1("%1 orphaned civs - putting them into my own array", count _orphanedCivs);
            GVAR(localCivs) = GVAR(localCivs) + _orphanedCivs;
        },
        30,
        []
    ] call CBA_fnc_addPerFrameHandler;
};
