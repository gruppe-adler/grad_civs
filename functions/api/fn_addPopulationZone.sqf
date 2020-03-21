#include "..\..\component.hpp"

params ["_area"];

GVAR(POPULATION_ZONES) pushBack _area;

INFO_1("added population zone %1", _area);
