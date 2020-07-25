#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (hasInterface) then {
    call FUNC(showHonkAtArea);
    call FUNC(showOnMap);
    call FUNC(showPinkArrows);
    call FUNC(showPointingHints);
    call FUNC(showInfoLine);
    call FUNC(showFps);
};


if (isServer || CBA_isHeadlessClient) then {
    GVAR(debugLoopHandle) = [{
        params ["_args", "_handle"];
        if (!isGameFocused || isGamePaused) exitWith {};
        if (call EGVAR(legacy,EXITON)) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
        if (GVAR(showInfoLine)) then {
            { _x call FUNC(updateInfoLine); } forEach EGVAR(legacy,localCivs);
        };
    }, 1, []] call CBA_fnc_addPerFrameHandler;

    [
        {
            if (GVAR(showFps)) then {
                [QGVAR(fps), [clientOwner, diag_fps]] call CBA_fnc_globalEvent;
            };
        },
        2,
        []
    ] call CBA_fnc_addPerFrameHandler;
};

if (isServer) then {
    [
        QEGVAR(common,civ_added),
        {
            params [["_civ", objNull, [objNull]]];
            _civ setVariable ["grad_civs_local_at", owner _civ, true];
            _civ addEventHandler ["Local", {
            	params ["_civ", ""];
                _civ setVariable ["grad_civs_local_at", owner _civ, true];
            }];
        }
   ] call CBA_fnc_addEventHandler;
};
