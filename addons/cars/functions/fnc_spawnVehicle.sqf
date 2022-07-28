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
        params ["_vec"];
        {
            [QEGVAR(activities,firedNear), [_x], _x] call CBA_fnc_targetEvent;
        } forEach (crew _vec);
     }
 ];

 _veh addEventHandler [
    "Killed",
    {
        params ["_unit", "_killer"];

        ["grad_civs_cars_vehKilled", [getPos _unit, _killer, _unit]] call CBA_fnc_globalEvent;
    }
 ];

private _animalChance = GVAR(animalTransportChance);
[_veh, _animalChance] call FUNC(loadAnimals);

_veh
