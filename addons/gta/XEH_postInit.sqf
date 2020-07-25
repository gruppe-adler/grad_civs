#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || CBA_isHeadlessClient) then {
    [] call FUNC(registerCivAddedHandler);
};

if (hasInterface) then {
    [] call FUNC(registerPlayerTheftHandler);
};
