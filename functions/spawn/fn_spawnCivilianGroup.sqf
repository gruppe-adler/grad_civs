#include "..\..\component.hpp"

params [
    ["_pos", [0, 0, 0]],
    ["_groupSize", 1],
    ["_vehicle", objNull]
];

private _group = createGroup [civilian, true];
_group setVariable ["grad_civs_isGradCiv",true];

for "_i" from 1 to _groupSize do {
    [_pos, _group, _vehicle] call grad_civs_fnc_spawnCivilian;
};

if (!(isNull _vehicle)) then {
    [_group, _vehicle] call grad_civs_fnc_setGroupVehicle;
};

_group
