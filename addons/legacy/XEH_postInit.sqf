#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("grad_civs is disabled. good bye.");
};

[] call FUNC(initCommonEventhandlers);
[] call FUNC(initHCs);

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
