params [
    ["_group", grpNull],
    ["_position", [0, 0, 0]],
    ["_timeout", [0, 0, 0]],
    ["_radius", 5]
];

private _waypoint = _group addWaypoint [_position, 0];
private _speed = (if (4 > random 100) then {"NORMAL"} else {"LIMITED"});

_waypoint setWaypointType "MOVE";
// _waypoint setWaypointBehaviour "SAFE"; // weirdly enough, this caused the group to mostly wait a looong time
_waypoint setWaypointSpeed _speed;
_waypoint setWaypointFormation "STAG COLUMN";
_waypoint setWaypointTimeout _timeout;
_waypoint setWaypointCompletionRadius _radius;

_waypoint
