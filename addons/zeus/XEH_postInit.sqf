#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (hasInterface) then {
    [] call FUNC(setupZeusModules);
};
