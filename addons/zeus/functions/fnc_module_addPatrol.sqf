#include "..\script_component.hpp"

params [
    ["_clickPos", [0, 0, 0], [[]]]
];

private _group = [[], [_clickPos#0, _clickPos#1, 0]] call EFUNC(patrol,addFootsy);

if (isNull _group) then {
    systemChat "could not add patrol. see RPT for details";
};
