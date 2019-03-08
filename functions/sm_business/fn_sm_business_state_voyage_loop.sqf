private _wpidx = currentWaypoint group _this;
private _wppos = waypointPosition ((waypoints (group _this)) select _wpidx);
[_this,  format ["traveling to waypoint %1, %2 (%3m left)", _wpidx, _wppos, _this distance _wppos]] call grad_civs_fnc_setCurrentlyThinking;
