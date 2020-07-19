#include "..\script_component.hpp"

private _deathPos = getPos _this;
private _killer = _this getVariable ["ace_medical_lastDamageSource", objNull];

INFO_2("releasing civ killed at %1 by %2", _deathPos, _killer);

["grad_civs_civKilled", [_deathPos, _killer]] call CBA_fnc_globalEvent;

GVAR(localCivs) = GVAR(localCivs) - [_this];
["grad_civs_civ_removed", [_this]] call CBA_fnc_globalEvent;

if ([QGVAR(cleanupCorpses)] call CBA_settings_fnc_get) then {
    addToRemainsCollector [_this];
};
