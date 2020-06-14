#include "..\script_component.hpp"

params [
    ["_civ", objNull, [objNull]],
    ["_smName", "", [""]]
];

private _sm = EGVAR(common,stateMachines) getVariable [_smName, locationNull];

assert(!isNull _sm);

[_civ, _sm, ""] call EFUNC(cba_statemachine,getCurrentState);
