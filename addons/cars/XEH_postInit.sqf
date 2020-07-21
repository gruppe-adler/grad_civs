#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);    
};
