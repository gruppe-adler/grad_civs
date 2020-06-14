private _grpMembers = units _this;
private _mountedCount = { vehicle _x != _x } count _grpMembers;

(_mountedCount == count _grpMembers) && (leader _this == _this)
