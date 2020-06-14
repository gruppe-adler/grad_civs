#include "..\script_component.hpp"

if ((ALL_HUMAN_PLAYERS isEqualTo []) && ([QGVAR(spawnOnlyWithPlayers)] call CBA_settings_fnc_get)) exitWith {
    INFO("no human players connected, will abstain from spawning civilians")
};

private _minCivUpdateTime = [QGVAR(minCivUpdateTime)] call cba_settings_fnc_get;
private _minFps = [QGVAR(minFps)] call cba_settings_fnc_get;

private _fps = diag_fps;
if (_fps < _minFps) exitWith {INFO_2("not spawning additional civs: less FPS than required (%1/%2)", _fps, _minFps)};
if ((_fps * _minCivUpdateTime) < (count GVAR(localCivs))) exitWith {INFO_3("not spawning additional civs: cannot guarantee update times less than %1 for %2 civs with %3 fps", _minCivUpdateTime, count GVAR(localCivs), _fps)};

[QGVAR(spawnAllowed), []] call CBA_fnc_localEvent;
