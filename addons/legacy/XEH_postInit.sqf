#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("grad_civs is disabled. good bye.");
};

[] call FUNC(initCommonEventhandlers);
[] call FUNC(initHCs);
[] call FUNC(initPlayer);
