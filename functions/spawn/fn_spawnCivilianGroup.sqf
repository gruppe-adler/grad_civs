#include "..\..\component.hpp"

params [
    ["_pos", [0, 0, 0]],
    ["_groupSize", 1],
    ["_vehicle", objNull],
    ["_primaryTask", ""]
];

if (_pos isEqualTo [0, 0, 0]) exitWith {ERROR("tried to spawn civs at 0,0,0"); grpNull};

private _group = createGroup [civilian, true];
_group setCombatMode "GREEN";

for "_i" from 1 to _groupSize do {
    [_pos, _group, _primaryTask] call grad_civs_fnc_spawnCivilian;
};

if (!(isNull _vehicle)) then {
    [_group, _vehicle] call grad_civs_fnc_setGroupVehicle;
};

_group
