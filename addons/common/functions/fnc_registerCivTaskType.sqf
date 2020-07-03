#include "..\script_component.hpp"

params [
        ["_type", "", [""]],
        ["_cleanupDistance", 99999, [0]],
        ["_despawnCondition", {false}, [{}]]
];

ISNILS(GVAR(civTaskTypes), false call CBA_fnc_createNamespace);

if (_type in (allVariables GVAR(civTaskTypes))) exitWith {
    ERROR_1("civTaskType %1 has already been registered", _type);
};

GVAR(civTaskTypes) setVariable [_type, [_cleanupDistance, _despawnCondition]];
