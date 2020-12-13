#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "2) lifecycle - performance & spawning"];

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
    {},
    false
] call CBA_fnc_addSetting;
