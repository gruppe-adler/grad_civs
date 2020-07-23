#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (hasInterface) then {
    [] call FUNC(setupZeusModules);
};
