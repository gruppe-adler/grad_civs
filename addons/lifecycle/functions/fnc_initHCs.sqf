#include "..\script_component.hpp"

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

GVAR(globalSpawnHandler) = [QGVAR(globalSpawn), FUNC(localSpawnPass)] call CBA_fnc_addEventHandler;

[FUNC(cleanupLocalCivs), 10, []] call CBA_fnc_addPerFrameHandler;

if (isServer) then {
    [FUNC(globalSpawnPass), 2, []] call CBA_fnc_addPerFrameHandler;
};

if (CBA_isHeadlessClient) then {
    [] call FUNC(overclockStateMachines);
    [FUNC(adoptAbandonedCivs), 30, []] call CBA_fnc_addPerFrameHandler;
};
