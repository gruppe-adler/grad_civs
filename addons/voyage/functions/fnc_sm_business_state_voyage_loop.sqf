#include "..\script_component.hpp"

private _group = group _this;
private _wps = waypoints _group;
private _wppos = waypointPosition (_wps select (currentWaypoint _group));

[_this,  format ["traveling to waypoint %1, %2 (%3m left)", currentWaypoint _group, _wppos, _this distance _wppos]] call EFUNC(legacy,setCurrentlyThinking);
