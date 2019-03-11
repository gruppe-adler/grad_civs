params [
    ["_player", objNull],
    ["_minSpawnDistance", 0],
    ["_maxSpawnDistance", 0]
];

private _spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
private _refPlayerPos = getPos _player;


private _dir = random 360;

private _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
private _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;

[_refPosX, _refPosY]
