#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

ISNILS(GVAR(EXITON), {false});

[] call FUNC(initCommonEventhandlers);

if (isServer || CBA_isHeadlessClient) then {
    [] call FUNC(initHCs);
};
