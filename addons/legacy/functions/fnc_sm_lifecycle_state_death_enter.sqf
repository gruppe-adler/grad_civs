#include "..\script_component.hpp"

private _deathPos = getPos _this;
private _killer = _this getVariable ["ace_medical_lastDamageSource", objNull];

// old killed event to be used with publicVariable EH
// DEPRECATED
CIV_KILLED = [_deathPos, _killer];
INFO_2("civ killed at %1 by %2", _deathPos, _killer);
publicVariableServer "CIV_KILLED";

// new killed event to be used with config
[_this, _killer] call GRAD_CIVS_ONKILLED;

// even newer CBA event magic
["grad_civs_civKilled", CIV_KILLED] call CBA_fnc_globalEvent;

GVAR(localCivs) = GVAR(localCivs) - [_this];
["grad_civs_civ_removed", [_this]] call CBA_fnc_globalEvent;

if ([QGVAR(cleanupCorpses)] call CBA_settings_fnc_get) then {
    addToRemainsCollector [_this];
};
