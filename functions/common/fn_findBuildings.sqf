#include "..\..\component.hpp"

params [
	["_searchPos", [0, 0, 0]],
	["_radius", 0],
	["_minPosCount", 1]
];

if (_searchPos isEqualTo [0, 0, 0]) exitWith {ERROR_1("invalid usage, _searchPos is Origin");[]};
if (_radius isEqualTo 0) exitWith {ERROR_1("invalid usage, _radius is %1", _radius);[]};

//exclusion list for houses
private _exclusionList = [
	"Land_Pier_F",
	"Land_Pier_small_F",
	"Land_NavigLight",
	"Land_LampHarbour_F",
	"Land_runway_edgelight"
];

//HOUSE LIST ===================================================================
_houseList = _searchPos nearObjects ["House", _radius];
LOG_3("%1 houses within %2m of %3, will whittle down by positions and excluded types", count _houseList, _radius, _searchPos);
//Clean up house list (remove buildings that have no positions)
_cleanUpCounter = 0;
{
	SCRIPT("findBuildings_filter");
	//_buildingPos = _x buildingPos 0;
	//if ((str _buildingPos) == "[0,0,0]") then {
	if (count (_x buildingPos -1) < _minPosCount) then {
			_houseList = _houseList - [_x];
			_cleanUpCounter = _cleanUpCounter + 1;
	} else {
        if (typeOf _x in _exclusionList) then {
            _houseList = _houseList - [_x];
            _cleanUpCounter = _cleanUpCounter + 1;
        };
    };
} forEach _houseList;

_houseList
