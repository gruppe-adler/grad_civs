#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]]
];

LOG_1("Looking for suitable players to spawn civilians around %1", _allPlayers);

if (!GVAR(spawnLimitEnabled)) exitWith {_allPlayers};

LOG_1("%1 is enabled, continuing", QGVAR(spawnLimitEnabled));

private _filteredPlayers = [];

{
    private _playerVehicle = vehicle _x;

    // If player is not in a vehicle, or is not in an air vehicle
    if (_playerVehicle isEqualTo _x || {!(_playerVehicle isKindOf "Air")}) then {
        _filteredPlayers pushBackUnique _x;

        continue;
    };

    private _playerHeight = getPosATL _playerVehicle # 2;
    private _playerSpeed = speed _playerVehicle;

    private _isSuitableCandidate = _playerHeight <= GVAR(spawnHeightLimit) && {_playerSpeed <= GVAR(spawnSpeedLimit)};

    LOG_2("Player %1 candidate status is %2", _x, _isSuitableCandidate);
    
    if (_isSuitableCandidate) then { _filteredPlayers pushBackUnique _x };
} forEach _allPlayers;

_filteredPlayers
