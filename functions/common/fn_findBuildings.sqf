#include "..\..\component.hpp"

params [
	["_searchPos", [0, 0, 0]],
	["_radius", 0],
	["_onlyEnterable", false]
];

if (_searchPos isEqualTo [0, 0, 0]) exitWith {ERROR_1("invalid usage, _searchPos is Origin");[]};
if (_radius isEqualTo 0) exitWith {ERROR_1("invalid usage, _radius is %1", _radius);[]};

private _houses = _searchPos nearObjects ["House", _radius];

if (_onlyEnterable) then {
	// this filter basically makes the whole function be like `nearestBuilding` with multiple results
	_houses select {
		!((_x buildingExit 0) isEqualTo [0, 0, 0])
	}
} else {
	_houses
}
