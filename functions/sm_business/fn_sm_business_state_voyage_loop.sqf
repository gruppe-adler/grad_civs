private _group = group _this;
private _wpidx = currentWaypoint _group;
private _wps = waypoints _group;
private _wppos = waypointPosition (_wps select _wpidx);

[_this,  format ["traveling to waypoint %1, %2 (%3m left)", _wpidx, _wppos, _this distance _wppos]] call grad_civs_fnc_setCurrentlyThinking;
