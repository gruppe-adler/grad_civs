#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [
        QEGVAR(legacy,spawnAllowed),
        {
            private _maxCivsInVehicles = GVAR(maxCivsInVehicles);
            if ((count (["voyage"] call EFUNC(legacy,getGlobalCivs))) < _maxCivsInVehicles) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addCarCrew);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
    [
        "voyage",
        _spawnDistances#1 * 1.5
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_mountUp"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
