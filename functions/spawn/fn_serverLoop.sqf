#include "..\..\component.hpp"

ASSERT_SERVER("");

if (!GRAD_CIVS_ENABLEDINVEHICLES && !GRAD_CIVS_ENABLEDONFOOT) exitWith {-1};

private _mainLoop = {
    params ["_args", "_handle"];

    if (call GRAD_CIVS_EXITON) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    [] call grad_civs_fnc_spawnPass;
};

grad_civs_mainLoop = [_mainLoop, 10, []] call CBA_fnc_addPerFrameHandler;


grad_civs_debugLoop = [{
    params ["_args", "_handle"];
    if (call GRAD_CIVS_EXITON) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
    if (GRAD_CIVS_DEBUGMODE) then {
        { _x call grad_civs_fnc_updateInfoLine; } forEach (GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS);
    };
}, 0.1, []] call CBA_fnc_addPerFrameHandler;
