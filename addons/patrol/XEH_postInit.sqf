#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [
        QEGVAR(legacy,spawnAllowed),
        {
            ISNILS(GVAR(maxCivsOnFoot), [QGVAR(maxCivsOnFoot)] call CBA_settings_fnc_get);
            if ((count (["patrol"] call EFUNC(legacy,getGlobalCivs))) < GVAR(maxCivsOnFoot)) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addFootsy);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = [[QGVAR(spawnDistancesOnFoot)] call CBA_settings_fnc_get] call EFUNC(common,parseCsv);
    [
        "patrol",
        _spawnDistances#1 * 1.5
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
