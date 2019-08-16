#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "postInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initHCs right now...")};

if (isServer || !hasInterface) then {
    if (!assert(isNil "GRAD_CIVS_STATEMACHINES")) exitWith {
        ERROR("Already initialized, not doing it a second time!");
    };
    INFO("Civs init running...");

    GRAD_CIVS_LOCAL_CIVS = [];
    GRAD_CIVS_STATEMACHINES = [] call CBA_fnc_createNamespace;

    [] call grad_civs_fnc_sm_lifecycle;
    [] call grad_civs_fnc_serverLoop;
};
