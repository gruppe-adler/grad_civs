params ["_path"];

private _restrictedAreas = missionNamespace getVariable ["GRAD_CIVS_RESTRICTED_AREAS", []];
private _isInArea = false;

{
    private _node = _x;
    {
        private _area = _x;
        if (_node inArea _area) exitWith {
            _isInArea = true;
        };
    } forEach _restrictedAreas;
} forEach _path;

diag_log format ["GRAD_civs: isInArea is %1", _isInArea];

_isInArea