#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civilians", "2) lifecycle - performance & spawning"];

[
    QGVAR(civClasses),
    "EDITBOX",
    "Unit classes to use for spawning civilians",
    _settingsGroup,
    "C_Man_1",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(cleanupCorpses),
    "CHECKBOX",
    "support corpseManagerMode",
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnOnlyWithPlayers),
    "CHECKBOX",
    "Spawn civilians only when players on server",
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnLimitEnabled),
    "CHECKBOX",
    ["Enable spawn limit", "Enable spawn limit which spawns civilians around players who are not flying beyond the max height and speed"],
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnHeightLimit),
    "SLIDER",
    ["Spawn height limit", "Civilians will not spawn around players that are in an air vehicle that is highter than this height"],
    _settingsGroup,
    [0, 1000, 200, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;


[
    QGVAR(spawnSpeedLimit),
    "SLIDER",
    ["Speed limit", "Civilians will not spawn around players that are flying faster than this speed"],
    _settingsGroup,
    [0, 360, 100, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(minCivOwnerFps),
    "SLIDER",
    "Keep civ owner fps over [1/s]",
    _settingsGroup,
    [10, 50, 30, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(minServerFps),
    "SLIDER",
    "Keep server fps over [1/s]",
    _settingsGroup,
    [10, 50, 40, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(minCivUpdateTime),
    "SLIDER",
    "Keep civ reaction times under [s]",
    _settingsGroup,
    [0.1, 10, 3, 1],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(smMultiplicator),
    "SLIDER",
    "CBA state machine speed multiplicator on HCs",
    _settingsGroup,
    [1, 10, 1, 0],
    true,
    {
        if (!CBA_isHeadlessClient) exitWith {};

        ISNILS(GVAR(efIDs), []);
        INFO_1("removing %1 previous addditional state machine ticks per frame", count GVAR(efIDs));
        {
            removeMissionEventHandler ["EachFrame", _x];
        } forEach GVAR(efIDs);
        GVAR(efIDs) = [];
    
        [] call FUNC(overclockStateMachines);
    },
    false
] call CBA_fnc_addSetting;
