#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "postInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initPlayer right now...")};

if (hasInterface) then {
    if (isNil "GRAD_CIVS_DEBUG_CIVSTATE") then {missionNamespace setVariable ["GRAD_CIVS_DEBUG_CIVSTATE",([missionConfigFile >> "cfgGradCivs","debugCivState",0] call BIS_fnc_returnConfigEntry) == 1]};
    if (isNil "GRAD_CIVS_INFOCHANNEL") then {GRAD_CIVS_INFOCHANNEL = 0;};

    [] call grad_civs_fnc_playerLoop;
    [] call grad_civs_fnc_registerAceInteractionHandler;
    if (GRAD_CIVS_DEBUG_CIVSTATE) then {
        [] call grad_civs_fnc_showWhatTheyThink;
        [{!isNull (findDisplay 12)}, {[] call grad_civs_fnc_mapMarkers}, []] call CBA_fnc_waitUntilAndExecute;
    };
};
