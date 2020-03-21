#include "..\..\component.hpp"

params ["_area"];

GVAR(EXCLUSION_ZONES) pushBackUnique _area;

INFO_1("added exclusion zone %1", _area);
