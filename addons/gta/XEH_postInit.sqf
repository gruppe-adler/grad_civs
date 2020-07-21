#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [] call FUNC(registerCivAddedHandler);
};

if (hasInterface) then {
    [] call FUNC(registerPlayerTheftHandler);
};
