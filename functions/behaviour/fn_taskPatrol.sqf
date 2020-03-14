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
    ["_groupOrUnit", grpNull],
    ["_centerPositionOrObject", [0, 0, 0]],
    ["_radius", 0],
    ["_count", 3],
    ["_timeout",[0,0,0]],
    ["_findPosOfInterest",false],
    ["_findRoadPos",false],
    ["_findWaterPos",false]
];

private _clearWaypoints =  {
    private _group = _this#0;
    private _waypoints = waypoints _group;
    {
        // Waypoint index changes with each deletion, so don't delete _x
        deleteWaypoint [_group, 0];
    } forEach _waypoints;
};

private _group = if (typeName _groupOrUnit == "OBJECT") then {group _groupOrUnit} else {_groupOrUnit};
private _centerPosition = if (typeName _centerPositionOrObject == "OBJECT") then {getPos _centerPositionOrObject} else {_centerPositionOrObject};
_radius = if (typeName _radius == "ARRAY") then {(random ((_radius select 1) - (_radius select 0))) + (_radius select 1)} else {_radius};
_count = if (typeName _count == "ARRAY") then {(random ((_count select 1) - (_count select 0))) + (_count select 1)} else {_count};
private _position = _centerPosition;

assert(_count > 0);

LOG_3("taskPatrol start. waypoints to be added: %1, group: %2. previous waypoints: %3", _count, _group, count waypoints _group);

if !(local _group) exitWith {};
[_group] call _clearWaypoints;

private _moveWps = [_position, _radius, _count, _findPosOfInterest, _findRoadPos, _findWaterPos] call FUNC(taskPatrolFindWaypoints);
{
    LOG_1("adding wp at %1", _x);
     [_group, _x, _timeout] call FUNC(taskPatrolAddWaypoint);
} forEach _moveWps;


// add home waypoint!
private _home = _group getVariable ["grad_civs_home", objNull];
if (!isNull _home) then {
    LOG_1("adding home wp at %1", getPos _home);
    [_group, getPos _home, [0, 15, 30], 20] call FUNC(taskPatrolAddWaypoint);
};
LOG("adding cycle wp close by group position");
// NOTE : a cycle waypoint points to the *closest waypoint other than the previous one*! which means in our case: close to the initial waypoint
[_group, _position vectorAdd [10, 0, 0]] call grad_civs_fnc_addCycleWaypoint;

LOG_2("taskPatrol end. waypoints for group %1 : %2", _group, count waypoints _group);
