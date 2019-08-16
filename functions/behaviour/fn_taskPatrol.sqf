/*  Creates random patrol for group
*
*   [group,position,radius,count] call grad_civs_taskPatrol;
*
*   Params:
*   0: group        group or unit
*   1: position     position or object - if object, position of object is used
*   2: radius       number or array - if array, random radius between first and second element is used
*   3: count        number > 1, or array - amount of waypoints to generate, if array, random amount between first and second element is used
*   4: timeout      array - waypoint timeout [min, mid, max]
*/

#include "..\..\component.hpp"

params [
    "_groupOrUnit",
    "_centerPositionOrObject",
    "_radius",
    "_count",
    ["_timeout",[0,0,0]],
    ["_findPosOfInterest",false],
    ["_findRoadPos",false],
    ["_findWaterPos",false]
];

private _group = if (typeName _groupOrUnit == "OBJECT") then {group _groupOrUnit} else {_groupOrUnit};
private _centerPosition = if (typeName _centerPositionOrObject == "OBJECT") then {getPos _centerPositionOrObject} else {_centerPositionOrObject};
_radius = if (typeName _radius == "ARRAY") then {(random ((_radius select 1) - (_radius select 0))) + (_radius select 1)} else {_radius};
_count = if (typeName _count == "ARRAY") then {(random ((_count select 1) - (_count select 0))) + (_count select 1)} else {_count};
private _position = _centerPosition;

assert(_count > 1);

if !(local _group) exitWith {};
[_group] call CBA_fnc_clearWaypoints;

//create waypoints
for [{_i=0}, {_i<_count}, {_i=_i+1}] do {
    private _searchPosition = [_centerPosition,[_radius / 2 ,_radius],[0,360],nil,_findWaterPos,_findRoadPos] call grad_civs_fnc_findRandomPos;

    private _inExclusionZone = {
        if (_searchPosition inArea _x) exitWith {true};
        false
    } forEach GRAD_CIVS_EXCLUSION_ZONES;
    if (!_inExclusionZone) then {
        if (count _searchPosition > 0) then {
            _position = if (_findPosOfInterest && {80 > random 100}) then {[_searchPosition, false] call grad_civs_fnc_findPositionOfInterest} else {_searchPosition};
            [_group, _position, _timeout] call grad_civs_fnc_taskPatrolAddWaypoint;
        };
    };
};

// add home waypoint!
private _home = _group getVariable ["grad_civs_home", objNull];
if (!isNull _home) then {
    [_group, getPos _home, [0, 15, 30], 20] call grad_civs_fnc_taskPatrolAddWaypoint;
};

[_group, _position vectorAdd [10, 0, 0]] call grad_civs_fnc_addCycleWaypoint;
