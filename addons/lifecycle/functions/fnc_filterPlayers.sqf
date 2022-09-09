#include "..\script_component.hpp"

params [
    ["_allPlayers", [], [[]]]
];

LOG_1("Looking for suitable players to spawn civilians around %1", _allPlayers);

if (!GVAR(spawnLimitEnabled)) exitWith {_allPlayers};

LOG_1("%1 is enabled, continuing", QGVAR(spawnLimitEnabled));

_allPlayers select {
    private _playerVehicle = objectParent _x;

    if (isNull _playerVehicle) then {
        true
    } else {
        private _playerHeight = getPosATL _playerVehicle # 2;
        private _playerSpeed = speed _playerVehicle;

        _playerHeight <= GVAR(spawnHeightLimit) && {_playerSpeed <= GVAR(spawnSpeedLimit)};
    };
};
