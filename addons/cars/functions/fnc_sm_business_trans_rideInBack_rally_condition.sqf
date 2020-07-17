#include "..\script_component.hpp"

private _leader = leader _this;
private _leaderStatus = [_leader, "business"] call EFUNC(common,civGetState);

private _leaderDismounts = _leaderStatus == "bus_dismount";
private _leaderRallyingAndDismounted = {_leaderStatus == "bus_rally" && vehicle _leader == _leader};

_leaderDismounts || _leaderRallyingAndDismounted
