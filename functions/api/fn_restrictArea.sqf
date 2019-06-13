#include "..\..\component.hpp"

/*

    ["mrk_restrictedArea_1"] call GRAD_civs_fnc_restrictArea;

*/

ASSERT_SERVER("restrict area must be run on server or hc");

params ["_area"];

private _existingAreas = missionNamespace getVariable ["GRAD_CIVS_RESTRICTED_AREAS", []];

_existingAreas pushbackUnique _area;

missionNamespace setVariable ["GRAD_CIVS_RESTRICTED_AREAS", _existingAreas, true];