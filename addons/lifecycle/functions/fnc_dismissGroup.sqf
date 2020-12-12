#include "..\script_component.hpp"

params [
    ["_group", grpNull, [grpNull]]
];

assert(local _group);

{
    [_x] call FUNC(dismissCiv);
} forEach units _group;

[_group] call CBA_fnc_clearWaypoints;

INFO_1("dismissed group %1", _group);
