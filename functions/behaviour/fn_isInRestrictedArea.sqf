params ["_position"];

private _restrictedAreas = missionNamespace getVariable ["GRAD_CIVS_RESTRICTED_AREAS", []];
private _isInArea = false;
{
    if (_position inArea _x) exitWith {
        _isInArea = true;
    };
} forEach _restrictedAreas;

_isInArea