#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "7) loadout"];

[
    QGVAR(backpacks),
    "EDITBOX",
    "Backpacks that civilians may wear",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(backpackProbability),
    "SLIDER",
    "Ratio of civs who will wear backpacks",
    _settingsGroup,
    [0, 1, 0.5, 0, true], // TODO when reading this setting, take care - its a percentage now
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(clothes),
    "EDITBOX",
    "Clothes that civilians must wear",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(headgear),
    "EDITBOX",
    "Headgear that civilians must wear",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(faces),
    "EDITBOX",
    "Faces that civilians must have.",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(goggles),
    "EDITBOX",
    "Goggles that civilians must wear",
    _settingsGroup,
    "[]",
    true,
    {},
    false
] call CBA_fnc_addSetting;
