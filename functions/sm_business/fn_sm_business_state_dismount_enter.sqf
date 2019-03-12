private _grp = group _this;

[_grp] call CBA_fnc_clearWaypoints;
_grp leaveVehicle vehicle _this;
unassignVehicle _this;
doStop units _grp;
