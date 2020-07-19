#include "..\script_component.hpp"

private _group = group _this;
if (isNull _group) exitWith {
    private _livedAs = _this getVariable ["grad_civs_livedAs", str _this];
    WARNING_5("unit %1 (type %2) in voyage loop has no group. will ignore. alive %3 index %4 pos %5", _livedAs, typeof _this, alive _this, EGVAR(legacy,localCivs) find _this, getPos _this);
};
private _wps = waypoints _group;
private _wppos = waypointPosition (_wps select (currentWaypoint _group));

[_this,  format ["traveling to waypoint %1, %2 (%3m left)", currentWaypoint _group, _wppos, _this distance _wppos]] call EFUNC(legacy,setCurrentlyThinking);
