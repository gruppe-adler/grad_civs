#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("grad_civs is disabled. good bye.");
};

[] call FUNC(initCommonEventhandlers);
[] call FUNC(initHCs);
[] call FUNC(initPlayer);
