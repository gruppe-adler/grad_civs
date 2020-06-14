#include "..\script_component.hpp"

params [
    ["_unit", objNull],
    ["_thoughts", ""]
];

if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then {
    _unit setVariable ["grad_civs_currentlyThinking", _thoughts];
};
