#include "..\script_component.hpp"

if ((ALL_HUMAN_PLAYERS isEqualTo []) && (GVAR(spawnOnlyWithPlayers)) && (GVAR(shouldWarnSpawnPass))) exitWith {
    INFO("no human players connected, will abstain from spawning civilians");
    GVAR(shouldWarnSpawnPass) = false;
};

GVAR(shouldWarnSpawnPass) = true;

private _minCivUpdateTime = GVAR(minCivUpdateTime);
private _minFps = GVAR(minCivOwnerFps);

private _fps = diag_fps;
if (_fps < _minFps) exitWith {LOG_2("not spawning additional civs: less FPS than required (%1/%2)", _fps, _minFps)};
if ((_fps * _minCivUpdateTime) < (count GVAR(localCivs))) exitWith {LOG_3("not spawning additional civs: cannot guarantee update times less than %1 for %2 civs with %3 fps", _minCivUpdateTime, count GVAR(localCivs), _fps)};

[QGVAR(localSpawn), []] call CBA_fnc_localEvent;
