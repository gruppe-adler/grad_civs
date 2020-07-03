#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [
        QEGVAR(legacy,spawnAllowed),
        {
            _maxVehiclesInTransit = [QGVAR(maxVehiclesInTransit)] call CBA_settings_fnc_get;
            if ((count (["transit"] call EFUNC(cars,getGlobalVehicles))) < _maxVehiclesInTransit) then {
                [] call FUNC(spawnSomething);
            };
        }
    ] call CBA_fnc_addEventHandler;

    ["business", ["bus_mountUp"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
    ["lifecycle", ["lfc_life", "lfc_despawn"], FUNC(sm_lifecycle)] call EFUNC(common,augmentStateMachine);
};
