#include "..\..\component.hpp"

params ["_unit"];

/* raise pointing tickets */
_otherUnits = _unit getVariable ["GRAD_civs_isPointedAtBy",[]];

if (player in _otherUnits) exitWith {
	INFO("player already in other units");
};

/* raise pointing counter globally */
_unit setVariable ["GRAD_civs_isPointedAtBy", _otherUnits + [player], true];


player setVariable ["GRAD_isPointingAtObj", _unit];
INFO_1("pointing at %1", _unit);
