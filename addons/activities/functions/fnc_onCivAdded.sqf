params [
	["_civ", objNull, [objNull]]
];
if (!local _civ) exitWith {};

private _panicCooldown = [GVAR(panicCooldown)] call EFUNC(common,parseCsv);
_civ setVariable["GRAD_CIVS_PANICCOOLDOWN" , random _panicCooldown, true];
