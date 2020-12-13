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

_veh addEventHandler [
    "FiredNear",
    {
        params ["_vec", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
        {
            [QEGVAR(activities,firedNear), [_x], _x] call CBA_fnc_targetEvent;
        } forEach (crew _vec);
     }
 ];

private _animalChance = GVAR(animalTransportChance);
[_veh, _animalChance] call FUNC(loadAnimals);

_veh
