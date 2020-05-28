#include "..\..\component.hpp"

params [
    ["_unit", objNull],
    ["_thoughts", ""]
];

if (GVAR(DEBUG_CIVSTATE)) then {
    _unit setVariable ["grad_civs_currentlyThinking", _thoughts];
};
