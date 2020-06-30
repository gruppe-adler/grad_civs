private _isLeader = (leader _this) == _this;
private _vehicle = vehicle _this;
private _allMounted = ((units _this) findIf { vehicle _x != _vehicle}) == -1;

_isLeader && _allMounted && (_this getVariable ["grad_civs_primaryTask", ""] == "transit")
