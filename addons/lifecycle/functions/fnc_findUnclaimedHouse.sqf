#include "..\script_component.hpp"

/* return house or objNull */

params [
    ["_position", [0, 0, 0], [[]]],
    ["_radius", 0, [0]],
    ["_getClosest", false, [true]]
];

LOG_2("looking for unclaimed house at %1 within %2 m", _position, _radius);

private _houses = [
    _position,
    _radius,
    true
] call FUNC(findBuildings);

private _minPosCount = 2;

LOG_3("%1 houses within %2m of %3, will whittle down by positions and excluded types", count _houses, _radius, _position);

private _filter = {
    // assumptions:
    // a) there will be many more houses than civs - hence, occupation filter should come last
    // b) there are many unsuited house types, and their number will grow (heck even *fences* can be of type "house") - good filter, comes first
    private _house = _x;

    private _isVisible = {
        !(isObjectHidden _x);
    };
    private _isUnoccupied = {
        (count (_x getVariable ["grad_civs_residents", []])) == 0;
    };
    private _hasEnoughPositions = {
        (count (_x buildingPos -1)) >= _minPosCount;
    };
    private _goodHouseType2 = {
        -1 == (GVAR(excludedParentClasses) findIf {_house isKindOf _x});
    };
    private _goodHouseType = !((typeOf _x) in GVAR(excludedFinalClasses));

    _goodHouseType && _goodHouseType2 && _hasEnoughPositions && _isUnoccupied && _isVisible
};

private _idx = -1;
if (_getClosest) then {
    private _closestDist = 999999;
    {
        _xDist = (getPos _x) distance _position;
        if (_xDist < _closestDist) then {
            _closestDist = _xDist;
            _idx = _forEachIndex;
        };
    } forEach (_houses select _filter);
} else {
    _idx = _houses findIf _filter;
};

if (_idx != -1) then {
    _houses select _idx
} else {
    objNull
}
