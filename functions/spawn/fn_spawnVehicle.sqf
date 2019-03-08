#include "..\..\component.hpp"

params ["_pos","_type"];

private _veh = _type createVehicle _pos;

clearBackpackCargo _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;

_veh addEventHandler ["FiredNear",
 {
     params ["_vec", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

     private _units = crew _vec;

     ["fired_near", _units, _units] call CBA_fnc_targetEvent;
 }];

_veh
