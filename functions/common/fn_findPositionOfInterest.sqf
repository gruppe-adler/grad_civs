#include "..\..\component.hpp"

params [
    ["_searchPosition", [0, 0, 0]],
    ["_isGetNearest", false]
];

if (_searchPosition isEqualType objNull) then {_searchPosition = getPos _searchPosition};

private _buildings = [];
if (_isGetNearest) then {
	_buildings append (nearestObjects [_searchPosition, ["House", "Building"], 100]);
} else {
	_buildings append (_searchPosition nearObjects ["House", 100]);
	_buildings append (_searchPosition nearObjects ["Building",100]);
};

private _nearestBuilding = if (count _buildings > 0) then {_buildings select 0} else {objNull};
private _buildingPositions = [_nearestBuilding] call BIS_fnc_buildingPositions;
private _position = if (count _buildingPositions > 0) then {selectRandom _buildingPositions} else {
	[_searchPosition,[50,100],[0,360]] call FUNC(findRandomPos);
};

if (_position isEqualTo []) then {
	_position = _searchPosition;
};

_position
