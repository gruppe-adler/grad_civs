#include "..\..\component.hpp"

private _deathPos = getPos _this;
private _killer = _this getVariable ["ace_medical_lastDamageSource", objNull];

// old killed event to be used with publicVariable EH
// DEPRECATED
CIV_KILLED = [_deathPos, _killer];
INFO_1("civ killed: %1", CIV_KILLED);
publicVariableServer "CIV_KILLED";

// new killed event to be used with config
[_this, _killer] call GRAD_CIVS_ONKILLED;

// even newer CBA event magic
["grad_civs_civKilled", CIV_KILLED] call CBA_fnc_globalEvent;

GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS - [_this];
["grad_civs_civ_removed", [_this]] call CBA_fnc_globalEvent;
addToRemainsCollector [_this];
