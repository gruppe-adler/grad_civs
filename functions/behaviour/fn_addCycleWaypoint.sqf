params [
    ["_group", grpNull],
    ["_position", [0, 0, 0]]
];

private _waypoint = _group addWaypoint [_position, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointBehaviour "SAFE";

_waypoint
