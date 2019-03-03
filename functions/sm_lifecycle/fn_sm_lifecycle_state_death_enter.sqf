#include "..\..\component.hpp"

private _deathPos = getPos _this;
private _killer = _this getVariable ["ace_medical_lastDamageSource", objNull];

// old killed event to be used with publicVariable EH
CIV_KILLED = [_deathPos, _killer];
INFO_1("civ killed: %1", CIV_KILLED);
publicVariableServer "CIV_KILLED";

// new killed event to be used with config
[_this, _killer] call GRAD_CIVS_ONKILLED;

GRAD_CIVS_ONFOOTUNITS deleteAt (GRAD_CIVS_ONFOOTUNITS find _this);
GRAD_CIVS_INVEHICLESUNITS deleteAt (GRAD_CIVS_INVEHICLESUNITS find _this);

if (GRAD_CIVS_DEBUGMODE) then {
        publicVariable "GRAD_CIVS_ONFOOTUNITS";
        publicVariable "GRAD_CIVS_INVEHICLESUNITS";
};
