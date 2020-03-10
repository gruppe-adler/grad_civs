#include "..\..\component.hpp"

if (!(isNil "GRAD_CIVS_INITIALIZED")) exitWith {
    WARNING("grad-civs already initialized (autoInit=1 maybe?), will NOT run again. If you're sure about this, unset GRAD_CIVS_INITIALIZED and try again!");
};
GRAD_CIVS_INITIALIZED = true;

INFO("running full grad-civs initialization now...");


// switchMove locality workaround
[
    QGVAR(switchMove), {
        params ["_unit", "_animation"];
        _unit switchMove _animation;
    }
] call CBA_fnc_addEventHandler;

[] call grad_civs_fnc_initConfig;
[] call grad_civs_fnc_initServer;
[] call grad_civs_fnc_initHCs;
[] call grad_civs_fnc_initPlayer;
