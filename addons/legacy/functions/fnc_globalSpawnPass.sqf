#include "..\script_component.hpp"

params ["", "_handle"];

if (hasInterface && (!isGameFocused || isGamePaused)) exitWith {};
if (call GVAR(EXITON)) exitWith {
    INFO_1("shutting down because %1 returned true", QGVAR(EXITON));
    [_handle] call CBA_fnc_removePerFrameHandler
};
if (diag_fps < GVAR(minServerFps)) exitWith {
    LOG_2("Server fps %1 is below minimum of %2 -  skipping spawn", diag_fps, GVAR(minServerFps));
};

if ((count (entities "HeadlessClient_F") > 0) && CBA_missionTime < 10) exitWith {}; // wait a few seconds for HCs to connect

private _hcs = (entities "HeadlessClient_F") arrayIntersect allPlayers;
if (count _hcs > 0) then {
    [QGVAR(globalSpawn), [], _hcs] call CBA_fnc_targetEvent;
} else {
    [QGVAR(globalSpawn), []] call CBA_fnc_serverEvent;
};
