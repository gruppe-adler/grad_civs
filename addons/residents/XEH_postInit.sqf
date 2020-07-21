#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [
        QEGVAR(legacy,spawnAllowed),
        {
            ISNILS(GVAR(maxCivsResidents), GVAR(maxCivsResidents));
            if ((count (["reside"] call EFUNC(legacy,getGlobalCivs))) < GVAR(maxCivsResidents)) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addResident);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = [GVAR(spawnDistancesResidents)] call EFUNC(common,parseCsv);
    [
        "reside",
        _spawnDistances#1 * 1.2
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
