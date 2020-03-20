#include "..\..\component.hpp"

params [
	["_searchPos", [0, 0, 0]],
	["_radius", 0]
];

if (_searchPos isEqualTo [0, 0, 0]) exitWith {ERROR_1("invalid usage, _searchPos is Origin");[]};
if (_radius isEqualTo 0) exitWith {ERROR_1("invalid usage, _radius is %1", _radius);[]};

_searchPos nearObjects ["House", _radius];
