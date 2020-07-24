#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("grad_civs is disabled. good bye.");
};

ISNILS(GVAR(EXITON), {false});

[] call FUNC(initCommonEventhandlers);
[] call FUNC(initHCs);
