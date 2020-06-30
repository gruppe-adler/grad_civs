#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [] call FUNC(registerCivAddedHandler);
};

if (hasInterface) then {
    [] call FUNC(registerPlayerTheftHandler);
};
