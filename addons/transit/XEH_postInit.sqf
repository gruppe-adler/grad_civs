#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(lifecycle,localSpawn),
        {
            _maxVehiclesInTransit = GVAR(maxVehiclesInTransit);
            if ((count (["transit"] call EFUNC(cars,getGlobalVehicles))) < _maxVehiclesInTransit) then {
                [] call FUNC(spawnSomething);
            };
        }
    ] call CBA_fnc_addEventHandler;

    ["business", ["bus_mountUp"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
    ["lifecycle", ["lfc_life", "lfc_despawn"], FUNC(sm_lifecycle)] call EFUNC(common,augmentStateMachine);
};
