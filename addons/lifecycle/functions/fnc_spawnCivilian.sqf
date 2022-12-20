#include "..\script_component.hpp"

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_group", grpNull, [grpNull]],
    ["_primaryTask", "", [""]],
    ["_civClasses", [], [[]]]
];

if (_civClasses isEqualTo []) then {
    _civClasses = call FUNC(config_getCivClasses);
};

private _civ = _group createUnit [selectRandom _civClasses, _pos, [], 0, "NONE"]; // TODO: ensure unit is not spawning within editor-placed rocks/houses

GVAR(localCivs) = GVAR(localCivs) + [_civ];

_civ setVariable ["grad_civs_primaryTask", _primaryTask, true];
_civ setVariable ["acex_headless_blacklist", true, true];
_civ setVariable ["lambs_danger_disableAI", true, true];

[QGVAR(civ_added), [_civ]] call CBA_fnc_globalEvent;

_civ
