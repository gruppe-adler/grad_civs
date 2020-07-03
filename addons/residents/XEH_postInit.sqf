#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (isServer || !hasInterface) then {
    [
        QEGVAR(legacy,spawnAllowed),
        {
            ISNILS(GVAR(maxCivsResidents), [QGVAR(maxCivsResidents)] call CBA_settings_fnc_get);
            if ((count (["reside"] call EFUNC(legacy,getGlobalCivs))) < GVAR(maxCivsResidents)) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addResident);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = parseSimpleArray ([QGVAR(spawnDistancesResidents)] call CBA_settings_fnc_get);
    [
        "reside",
        _spawnDistances#1 * 1.2
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
