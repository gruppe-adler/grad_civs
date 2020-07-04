#include "..\script_component.hpp"

params ["_pos","_type"];

private _veh = _type createVehicle _pos;

if (isNull _veh) exitWith {
    ERROR_2("could not create vehicle of class %1 at %2 (unknown class name?)", _type, _pos);
};

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

private _animalChance = [QGVAR(animalTransportChance)] call CBA_settings_fnc_get;
[_veh, _animalChance] call FUNC(loadAnimals);

_veh