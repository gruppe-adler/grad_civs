params [
    ["_allPlayers", []],
    ["_pos", [0, 0]],
    ["_minDistance", 0]
];

{
    if (((getPos _x) distance _pos) < _minDistance) exitWith {false};
    true
} forEach _allPlayers;
