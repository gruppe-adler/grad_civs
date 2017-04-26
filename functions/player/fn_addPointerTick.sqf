params ["_unit"];

/* raise pointing tickets */
_otherUnits = _unit getVariable ["GRAD_civs_isPointedAtBy",[]];

if (player in _otherUnits) exitWith {
	diag_log format ["player already in other units"];
};

/* raise pointing counter globally */
_unit setVariable ["GRAD_civs_isPointedAtBy", _otherUnits + [player], true];


player setVariable ["GRAD_isPointingAtObj", _unit];
diag_log format ["pointing at %1", _unit];