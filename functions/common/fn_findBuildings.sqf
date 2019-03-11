#include "..\..\component.hpp"

params ["_searchPos","_radius", ["_minPosCount", 1]];

//exclusion list for houses
_exclusionList = [
	"Land_Pier_F",
	"Land_Pier_small_F",
	"Land_NavigLight",
	"Land_LampHarbour_F",
	"Land_runway_edgelight"
];

if (count _searchPos == 0) exitWith {[]};

//HOUSE LIST ===================================================================
_houseList = nearestObjects [_searchPos,["House"],_radius];

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
