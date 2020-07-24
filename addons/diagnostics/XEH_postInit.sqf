#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (hasInterface) then {
    call FUNC(showHonkAtArea);
    call FUNC(showOnMap);
    call FUNC(showPinkArrows);
    call FUNC(showPointingHints);
    call FUNC(showInfoLine);
};

if (!hasInterface || isServer) then {
    GVAR(debugLoopHandle) = [{
        params ["_args", "_handle"];
        if (!isGameFocused || isGamePaused) exitWith {};
        if (call EGVAR(legacy,EXITON)) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
        if (GVAR(showInfoLine)) then {
            { _x call FUNC(updateInfoLine); } forEach EGVAR(legacy,localCivs);
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
};

if (hasInterface) then {
    [
        "server_fps",
        {
            if (GVAR(debugFps)) then {
                systemChat format ["%1 fps on %2", _this select 1, _this select 0];
            };
        }
    ] call CBA_fnc_addEventHandler;
};
