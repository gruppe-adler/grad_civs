#include "..\script_component.hpp"

params ["_area"];

ISNILS(GVAR(EXCLUSION_ZONES), []);
GVAR(EXCLUSION_ZONES) pushBackUnique _area;

INFO_1("added exclusion zone %1", _area);
