#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(lifecycle,localSpawn),
        {
            if ((count (["transit"] call EFUNC(cars,getGlobalVehicles))) < GVAR(maxVehiclesInTransit)) then {
                [] call FUNC(spawnSomething);
            };
        }
    ] call CBA_fnc_addEventHandler;

    ["business", ["bus_mountUp"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
    ["lifecycle", ["lfc_life", "lfc_despawn"], FUNC(sm_lifecycle)] call EFUNC(common,augmentStateMachine);
};
