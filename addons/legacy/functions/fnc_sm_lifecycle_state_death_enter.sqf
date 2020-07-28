#include "..\script_component.hpp"

private _deathPos = getPos _this;
private _killer = _this getVariable ["ace_medical_lastDamageSource", objNull];
_this setVariable ["grad_civs_livedAs", str _this, true]; // as dead units dont have a group - or the group mightve been deleted since - this var is my only way to identify the body later on

INFO_3("releasing civ %1 killed at %2 by %3", _this, _deathPos, _killer);

["grad_civs_civKilled", [_deathPos, _killer]] call CBA_fnc_globalEvent;

GVAR(localCivs) = GVAR(localCivs) - [_this];
[QEGVAR(common,civ_removed), [_this]] call CBA_fnc_globalEvent;

if (GVAR(cleanupCorpses)) then {
    addToRemainsCollector [_this];
};
