#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(legacy,localSpawn),
        {
            ISNILS(GVAR(maxCivsOnFoot), GVAR(maxCivsOnFoot));
            if ((count (["patrol"] call EFUNC(legacy,getGlobalCivs))) < GVAR(maxCivsOnFoot)) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addFootsy);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = [GVAR(spawnDistancesOnFoot)] call EFUNC(common,parseCsv);
    [
        "patrol",
        _spawnDistances#1 * 1.5
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
