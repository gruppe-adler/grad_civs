#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(lifecycle,localSpawn),
        {
            ISNILS(GVAR(maxCivsResidents), GVAR(maxCivsResidents));
            if ((count (["reside"] call EFUNC(lifecycle,getGlobalCivs))) < GVAR(maxCivsResidents)) then {
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
