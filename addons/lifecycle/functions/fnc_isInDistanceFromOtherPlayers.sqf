#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]],
    ["_posOrObject", [0, 0], [[], objNull]],
    ["_minDistance", 0, [0]]
];

{
    if (((getPos _x) distance _posOrObject) < _minDistance) exitWith {false};
    true
} forEach _allPlayers;
