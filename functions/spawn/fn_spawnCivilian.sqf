#include "..\..\component.hpp"

params ["_pos"];

private _group = createGroup [civilian, true];
_group setVariable ["grad_civs_isGradCiv",true];
private _unit = _group createUnit ["C_man_1", _pos, [], 0, "NONE"];

_unit disableAI "FSM";
_unit setBehaviour "CARELESS";

[_unit] call grad_civs_fnc_dressAndBehave;
_unit enableDynamicSimulation true;

[_unit] call GRAD_CIVS_ONSPAWN;

_unit
