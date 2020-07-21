#include "..\script_component.hpp"

if (isServer || !hasInterface) then {
    INFO("Server/HC init running...");

    if (
        (GVAR(cleanupCorpses)) &&
        !(([missionConfigFile, "corpseManagerMode", -1] call BIS_fnc_returnConfigEntry) in [1, 3])
    ) then {
        WARNING("'cleanupCorpses' flag is set, but 'corpseManagerMode' in description.ext is switched off!");
    };

    GVAR(localCivs) = [];
    EGVAR(common,stateMachines) = false call CBA_fnc_createNamespace;

    [] call FUNC(sm_lifecycle);
    [] call FUNC(serverLoop);
};
