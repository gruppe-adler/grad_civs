#include "..\script_component.hpp"

params ["_target"];

private _veh = vehicle _target; // target may be a vehicle itself
private _civ = driver _veh;

alive _civ &&
    (_civ isKindOf "Man") &&
    ([_civ] call EFUNC(activities,doingCustomActivity))
