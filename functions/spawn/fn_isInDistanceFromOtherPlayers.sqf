params [
    ["_allPlayers", []],
    ["_pos", [0, 0]],
    ["_minSpawnDistance", 0]
];

{
    if (((getPos _x) distance _pos) < _minSpawnDistance) exitWith {false};
    true
} forEach _allPlayers;
