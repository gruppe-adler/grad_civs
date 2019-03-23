params [
    ["_allPlayers", []],
    ["_pos", [0, 0]],
    ["_minSpawnDistance", 0],
    ["_maxSpawnDistance", 0]
];

private _minDistance = 128000; // 128 km should be enough for everybody.
private _maxDistance = 0;
{
    private _distance = (getPos _x) distance _pos;
    _minDistance = _minDistance min _distance;
    _maxDistance = _maxDistance max _distance;
} forEach _allPlayers;

(_minDistance >= _minSpawnDistance) && (_maxDistance <= _maxSpawnDistance)
