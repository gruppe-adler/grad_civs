#include "..\script_component.hpp"

if (isNull _this) exitWith {
    // natural occurrence, transit despawns civs routinely
};

private _group = group _this;
if (isNull _group) exitWith {
    private _livedAs = _this getVariable ["grad_civs_livedAs", str _this];
    WARNING_5("unit %1 (type %2) in voyage loop has no group. will ignore. alive %3 index %4 pos %5", _livedAs, typeof _this, alive _this, EGVAR(legacy,localCivs) find _this, getPos _this);
};

private _wpidx = currentWaypoint _group;
private _wps = waypoints _group;
private _wppos = waypointPosition (_wps select _wpidx);

[_this,  format ["traveling to transit sink %1, %2 (%3m left)", _wpidx, _wppos, _this distance _wppos]] call EFUNC(legacy,setCurrentlyThinking);
