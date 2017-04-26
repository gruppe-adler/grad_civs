/* rip from diod */

#include "..\..\component.hpp"

params ["_searchPosition"];

_buildings = nearestObjects [_searchPosition, ["House", "Building"], 100];
_nearestBuilding = if (count _buildings > 0) then {_buildings select 0} else {objNull};
_buildingPositions = [_nearestBuilding] call BIS_fnc_buildingPositions;
_position = if (count _buildingPositions > 0) then {selectRandom _buildingPositions} else {
	[_searchPosition,[50,100],[0,360]] call grad_civs_fnc_findRandomPos;
};

_position
