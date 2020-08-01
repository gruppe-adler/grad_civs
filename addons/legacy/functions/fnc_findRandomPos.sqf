// TODO afaict, this function does not return an even distribution over all of the desired area

#include "..\script_component.hpp"

params [
    ["_center", [0, 0, 0]],
    ["_radii", [0,15]],
    ["_angles", [0,360]],
    ["_vehicleType", "B_Soldier_F"],
    ["_findWaterPos",false],
    ["_findRoadPos",false]
];
private _pos = [];

_radii params ["_minRad", "_maxRad"];
_angles params ["_minAngle", "_maxAngle"];

if (_center isEqualType objNull) then {_center = getPos _center};

for [{private _i=0}, {_i<25}, {_i=_i+1}] do {
    _pos = [];
    private _searchDist = (random (_maxRad - _minRad)) + _minRad;
    private _searchAngle = (random (_maxAngle - _minAngle)) + _minAngle;
    private _searchPos = _center getPos [_searchDist, _searchAngle];

    if (_findRoadPos) then {
        private _nearRoads = _searchPos nearRoads 250;        
        _searchPos = if (count _nearRoads > 0) then {
            private _closestRoad = floor (count _nearRoads / 2); 
            getPos (_nearRoads select _closestRoad)
        } else {
            []
        };
    };

    _pos = if (_vehicleType != "" && {count _searchPos > 0}) then {_searchPos findEmptyPosition [0,10,_vehicleType]} else {_searchPos};
    if (
        count _pos > 0 &&
        {(surfaceIsWater _pos) isEqualTo _findWaterPos} &&
        {[_pos] call FUNC(isInPopulatedZone)}
    ) exitWith {};
};

_pos // return position or empty array
