#include "..\..\component.hpp"

private _vec = vehicle _this;
if (_vec != _this) then {
    private _count = {
        GRAD_CIVS_ONFOOTUNITS deleteAt (GRAD_CIVS_ONFOOTUNITS find _x);
        GRAD_CIVS_INVEHICLESUNITS deleteAt (GRAD_CIVS_INVEHICLESUNITS find _x);
        _vec deleteVehicleCrew _x;
        true
    } count crew _vec;
    deleteVehicle _vec;
    INFO_1("vehicle with %1 civs was despawned", _count);
} else {
    GRAD_CIVS_ONFOOTUNITS deleteAt (GRAD_CIVS_ONFOOTUNITS find _this);
    GRAD_CIVS_INVEHICLESUNITS deleteAt (GRAD_CIVS_INVEHICLESUNITS find _this);
    deleteVehicle _this;
    INFO("1 civ was despawned");
};

if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_ONFOOTUNITS"; publicVariable "GRAD_CIVS_INVEHICLESUNITS";};
