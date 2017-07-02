#include "..\..\component.hpp"

params ["_pos","_type"];

private _veh = _type createVehicle _pos;

clearBackpackCargo _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;

_veh
