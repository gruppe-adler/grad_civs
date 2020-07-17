#include "..\script_component.hpp"

private _leader = leader _this;

if (_leader == _this) exitWith {false};

private _leaderStatus = [_leader, "business"] call EFUNC(common,civGetState);
private _grpVeh = _this call FUNC(getGroupVehicle);

private _leaderIsCallingForMountUp = (_leaderStatus == "bus_mountUp");
private _leaderIsRallyingAndMounted = {_leaderStatus == "bus_rally" && vehicle _leader == _grpVeh};

_leaderIsCallingForMountUp || _leaderIsRallyingAndMounted
