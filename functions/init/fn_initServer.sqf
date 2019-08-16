#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "postInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initServer right now...")};

if (isServer) then {
    INFO("server init running...");
    missionNamespace setVariable ["GRAD_CIVS_INFOCHANNEL", [] call grad_civs_fnc_createInfoChannel, true];
};
