#include "..\..\component.hpp"

params ["_unit"];

/* remove pointing tickets */
_otherUnits = _unit getVariable ["GRAD_civs_isPointedAtBy",[]];

/* remove counter globally */
_unit setVariable ["GRAD_civs_isPointedAtBy", _otherUnits - [player], true];

player setVariable ["GRAD_isPointingAtObj", objNull];
INFO_1("no point anymore at %1", _unit);
