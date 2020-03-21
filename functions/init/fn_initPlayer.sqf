#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "postInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initPlayer right now...")};

if (hasInterface) then {
    if (isNil QGVAR(DEBUG_CIVSTATE)) then {missionNamespace setVariable [QGVAR(DEBUG_CIVSTATE),([missionConfigFile >> "cfgGradCivs","debugCivState",0] call BIS_fnc_returnConfigEntry) == 1]};
    if (isNil QGVAR(INFOCHANNEL)) then {GRAD_CIVS_INFOCHANNEL = 0;};

    [] call FUNC(playerLoop);
    [] call FUNC(registerAceInteractionHandler);
    [] call FUNC(setupZeusModules);
    if (GRAD_CIVS_DEBUG_CIVSTATE) then {
        [] call FUNC(showWhatTheyThink);

        [{!isNull (findDisplay 12)}, {[] call FUNC(mapMarkers)}, []] call CBA_fnc_waitUntilAndExecute;
    };
};
