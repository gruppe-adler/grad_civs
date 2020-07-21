#include "..\script_component.hpp"

params [
    ["_unit", objNull],
    ["_thoughts", ""]
];

if ((GVAR(debugCivState))) then {
    _unit setVariable ["grad_civs_currentlyThinking", _thoughts];
};
