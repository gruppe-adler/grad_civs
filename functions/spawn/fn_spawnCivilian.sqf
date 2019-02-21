#include "..\..\component.hpp"

params [
    ["_pos", [0, 0, 0]],
    ["_group", grpNull],
    ["_vehicle", objNull]    
];

private _unit = _group createUnit ["C_man_1", _pos, [], 0, "NONE"];

_unit disableAI "FSM";
_unit setBehaviour "CARELESS";
[_unit] call grad_civs_fnc_dressAndBehave;
_unit enableDynamicSimulation true;

[_unit, _vehicle] call GRAD_CIVS_ONSPAWN;

_unit
