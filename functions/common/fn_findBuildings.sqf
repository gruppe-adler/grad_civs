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
_houseList = nearestObjects [_searchPos, ["House"], _radius];

//Clean up house list (remove buildings that have no positions)
_cleanUpCounter = 0;
{

	//_buildingPos = _x buildingPos 0;
	//if ((str _buildingPos) == "[0,0,0]") then {
	if (count ([_x] call BIS_fnc_buildingPositions) < _minPosCount) then {
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
