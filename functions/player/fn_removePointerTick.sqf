#include "..\..\component.hpp"

params ["_unit","_pointer"];

/* remove pointing tickets */
private _otherUnits = _unit getVariable ["GRAD_civs_isPointedAtBy",[]];

/* remove counter globally */
_unit setVariable ["GRAD_civs_isPointedAtBy", _otherUnits - [_pointer], true];
