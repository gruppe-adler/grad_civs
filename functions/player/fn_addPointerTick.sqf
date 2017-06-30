#include "..\..\component.hpp"

params ["_unit","_pointer"];

/* raise pointing tickets */
private _otherUnits = _unit getVariable ["grad_civs_isPointedAtBy",[]];

if (_pointer in _otherUnits) exitWith {};

/* raise pointing counter globally */
_unit setVariable ["grad_civs_isPointedAtBy", _otherUnits + [_pointer], true];
