#include "..\script_component.hpp"

private _vec = vehicle _this;
if (_vec != _this) then {
    GVAR(localCivs) = GVAR(localCivs) - (crew _vec);
    [QGVAR(civ_removed), (crew _vec)] call CBA_fnc_globalEvent;
    private _count = count crew _vec;
    deleteVehicleCrew _vec;
    deleteVehicle _vec;
    INFO_1("vehicle with %1 civs was despawned", _count);
} else {
    GVAR(localCivs) = GVAR(localCivs) - [_this];
    [QGVAR(civ_removed), [_this]] call CBA_fnc_globalEvent;
    deleteVehicle _this;
    INFO("1 civ was despawned");
};
