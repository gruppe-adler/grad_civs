#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (isServer || CBA_isHeadlessClient) then {
        ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);

        ISNILS(GVAR(pfh_speedLimit_interval), EGVAR(lifecycle,minCivUpdateTime));
        GVAR(pfh_speedLimit) = [FUNC(pfh_speedLimit), GVAR(pfh_speedLimit_interval)] call CBA_fnc_addPerFrameHandler;

        ISNILS(GVAR(localCars), []);
        [QGVAR(car_added), {
            params ["_veh"];
            if (local _veh) then {
                GVAR(localCars) pushBackUnique _veh;
            };
        }] call CBA_fnc_addEventHandler;
        [QGVAR(vehKilled), {
            params ["_veh"];
            GVAR(localCars) = GVAR(localCars) - [_veh];
        }] call CBA_fnc_addEventHandler;
        GVAR(pfh_groomCarsArray) = [{
            GVAR(localCars) = GVAR(localCars) select {!(isNull _x)};
        }, 5] call CBA_fnc_addPerFrameHandler;

    };
}] call CBA_fnc_addEventHandler;
