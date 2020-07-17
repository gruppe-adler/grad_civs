private _civ = _this;

private _isLeader = (leader _civ) == _civ;

private _allMounted = {
    private _units = units _civ;
    private _mountedUnits = crew vehicle _civ;
    (_units arrayIntersect _mountedUnits) isEqualTo _units
};

private _isTaskTransit = {
    _civ getVariable ["grad_civs_primaryTask", ""] == "transit"
};

_isLeader && _allMounted && _isTaskTransit
