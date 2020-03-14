#include "..\..\component.hpp"

private _vec = vehicle _this;
if (_vec != _this) then {
    GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS - (crew _vec);
    [QGVAR(civ_removed), (crew _vec)] call CBA_fnc_globalEvent;
    private _count = {
        _vec deleteVehicleCrew _x;
        true
    } count crew _vec;
    deleteVehicle _vec;
    INFO_1("vehicle with %1 civs was despawned", _count);
} else {
    GRAD_CIVS_LOCAL_CIVS = GRAD_CIVS_LOCAL_CIVS - [_this];
    [QGVAR(civ_removed), [_this]] call CBA_fnc_globalEvent;
    deleteVehicle _this;
    INFO("1 civ was despawned");
};
