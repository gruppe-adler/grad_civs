#include "..\..\component.hpp"

params ["_area",["_vehicleType","B_Soldier_F"],["_findWaterPos",false],["_findRoadPos",false]];

_pos = [];
for [{private _i=0}, {_i<25}, {_i=_i+1}] do {
    _searchPos = _area call BIS_fnc_randomPosTrigger;

    if (_findRoadPos) then {
        _nearRoads = _searchPos nearRoads 50;
        _searchPos = if (count _nearRoads > 0) then {getPos (_nearRoads select 0)} else {[]};
    };

    _pos = if (_vehicleType != "" && {count _searchPos > 0}) then {_searchPos findEmptyPosition [0,10,_vehicleType]} else {_searchPos};
    if (count _pos > 0 && {(surfaceIsWater _pos) isEqualTo _findWaterPos}) exitWith {};
};

_pos
