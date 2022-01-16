#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(lifecycle,localSpawn),
        {
            ISNILS(GVAR(maxCivsOnFoot), GVAR(maxCivsOnFoot));
            LOG("checking for maxCivsOnFoot / whether i am allowed to spawn more patrols");
            if ((count (["patrol"] call EFUNC(lifecycle,getGlobalCivs))) < GVAR(maxCivsOnFoot)) then {
                LOG("calling addFootsy");
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
