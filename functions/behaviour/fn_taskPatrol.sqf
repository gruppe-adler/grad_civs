/*  Creates random patrol for group
*
*   [group,position,radius,count] call grad_civs_taskPatrol;
*
*   Params:
*   0: group        group or unit
*   1: position     position or object - if object, position of object is used
*   2: radius       number or array - if array, random radius between first and second element is used
*   3: count        number or array - amount of waypoints to generate, if array, random amount between first and second element is used
*   4: timeout      array - waypoint timeout [min, mid, max]
*/

#include "..\..\component.hpp"

params ["_group","_centerPosition","_radius","_count",["_timeout",[0,0,0]],["_findPosOfInterest",false],["_findRoadPos",false],["_findWaterPos",false]];
private ["_waypoint","_position"];

private _group = if (typeName _group == "OBJECT") then {group _group} else {_group};
private _centerPosition = if (typeName _centerPosition == "OBJECT") then {getPos _centerPosition} else {_centerPosition};
private _radius = if (typeName _radius == "ARRAY") then {(random ((_radius select 1) - (_radius select 0))) + (_radius select 1)} else {_radius};
private _count = if (typeName _count == "ARRAY") then {(random ((_count select 1) - (_count select 0))) + (_count select 1)} else {_count};

if !(local _group) exitWith {};
[_group] call CBA_fnc_clearWaypoints;


//create waypoints
for [{_i=0}, {_i<_count}, {_i=_i+1}] do {
    _searchPosition = [_centerPosition,[0,_radius],[0,360],nil,_findWaterPos,_findRoadPos] call grad_civs_fnc_findRandomPos;
    _position = if (_findPosOfInterest && {80 > random 100}) then {[_searchPosition] call grad_civs_fnc_findPositionOfInterest} else {_searchPosition};
    _waypoint = _group addWaypoint [_position, 0];

    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointSpeed (if (4 > random 100) then {"NORMAL"} else {"LIMITED"});
    _waypoint setWaypointFormation "STAG COLUMN";
    _waypoint setWaypointTimeout _timeout;
    _waypoint setWaypointCompletionRadius 1;
};


//cycle
_waypoint = _group addWaypoint [_position vectorAdd [10,0,0], 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointBehaviour "SAFE";
