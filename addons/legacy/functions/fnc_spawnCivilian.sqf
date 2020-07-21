#include "..\script_component.hpp"

params [
    ["_pos", [0, 0, 0]],
    ["_group", grpNull],
    ["_primaryTask", ""]
];

private _civClasses = call EFUNC(common,config_getCivClasses);
private _civ = _group createUnit [selectRandom _civClasses, _pos, [], 0, "NONE"]; // TODO: ensure unit is not spawning within editor-placed rocks/houses

GVAR(localCivs) = GVAR(localCivs) + [_civ];

_civ setVariable ["grad_civs_primaryTask", _primaryTask, true];
_civ setVariable ["acex_headless_blacklist", true, true];

[QGVAR(civ_added), [_civ]] call CBA_fnc_globalEvent;

_civ
