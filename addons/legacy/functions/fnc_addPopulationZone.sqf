#include "..\script_component.hpp"

params ["_area"];

ISNILS(GVAR(POPULATION_ZONES), []);
GVAR(POPULATION_ZONES) pushBack _area;

INFO_1("added population zone %1", _area);
