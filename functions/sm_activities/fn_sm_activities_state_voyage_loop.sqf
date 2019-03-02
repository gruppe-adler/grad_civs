private _wpidx = currentWaypoint group _this;
private _wppos = waypointPosition ((waypoints (group _this)) select _wpidx);
[_this,  format ["traveling to waypoint %3, %1 (%2m left)", _wppos, _this distance _wppos, _wpidx]] call grad_civs_fnc_setCurrentlyThinking;
