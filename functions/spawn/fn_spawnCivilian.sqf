#include "..\..\component.hpp"

params [
    ["_pos", [0, 0, 0]],
    ["_group", grpNull],
    ["_primaryTask", ""]
];

private _civ = _group createUnit [GVAR(CIVCLASS), _pos, [], 0, "NONE"];

GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS + [_civ];
[QGVAR(civ_added), [_civ]] call CBA_fnc_globalEvent;


_civ setVariable ["grad_civs_primaryTask", _primaryTask, true];
_civ setVariable ["acex_headless_blacklist", true, true];

_civ
