#include "..\..\component.hpp"

ASSERT_SERVER("populate area must be run on server or hc");
if (!canSuspend) exitWith {_this spawn grad_civs_fnc_populateArea};

params ["_area"];

private _areas = if (_area isEqualType objNull) then {synchronizedObjects _area} else {[_area]};

private _existingAreas = missionNamespace getVariable ["GRAD_CIVS_RESTRICTED_AREAS", []];

{
    _existingAreas pushbackUnique _areas;
} forEach _areas;