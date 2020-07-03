#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);    
};
