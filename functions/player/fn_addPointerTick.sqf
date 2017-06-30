#include "..\..\component.hpp"

params ["_unit","_pointer"];

/* raise pointing tickets */
_otherUnits = _unit getVariable ["GRAD_civs_isPointedAtBy",[]];

if (_pointer in _otherUnits) exitWith {};

/* raise pointing counter globally */
_unit setVariable ["GRAD_civs_isPointedAtBy", _otherUnits + [_pointer], true];
