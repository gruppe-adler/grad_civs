#include "..\script_component.hpp"

params ["_area"];

ISNILS(GVAR(EXCLUSION_ZONES), []);

private _zoneIdx = GVAR(EXCLUSION_ZONES) findIf {
	_area isEqualTo (if(_x isEqualType []) then [{_x#0}, {_x}]);
};

if(_zoneIdx isEqualTo -1) exitWith{};

GVAR(EXCLUSION_ZONES) deleteAt _zoneIdx;

INFO_1("removed exclusion zone %1", _area);
