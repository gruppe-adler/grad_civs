#include "..\script_component.hpp"

params [
    ["_clickPos", [0, 0, 0], [[]]]
];

private _group = [[], [_clickPos#0, _clickPos#1, 0]] call EFUNC(voyage,addCarCrew);

if (isNull _group) then {
    systemChat "could not add car. see RPT for details";
};
