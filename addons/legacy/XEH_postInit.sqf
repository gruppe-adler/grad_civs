#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

ISNILS(GVAR(EXITON), {false});

[] call FUNC(initCommonEventhandlers);
[] call FUNC(initHCs);
