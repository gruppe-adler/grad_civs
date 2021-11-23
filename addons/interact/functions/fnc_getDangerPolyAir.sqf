#include "..\script_component.hpp"

params [
	["_vic", objNull, [objNull]]
];

assert(!isNull _vic);

ISNILS(GVAR(flyScareVelocityAdjustmentFactor), 10);
ISNILS(GVAR(flyScareVelocitySpread), 0.25);
ISNILS(GVAR(vicBoxWidth), 10);
ISNILS(GVAR(vicBoxLength), 40 + (GVAR(vicBoxWidth) / 2));

private _velocity = velocity _vic;
_velocity = vectorLinearConversion [0, 1, 0.5, _velocity, [0, 0, -1], true]; // add scary downwash. also stabilize influence area at low speeds.
private _velocity1 = vectorNormalized _velocity;
_velocity = _velocity vectorMultiply GVAR(flyScareVelocityAdjustmentFactor);

private _speed = vectorMagnitude _velocity;


if (_speed < GVAR(vicBoxLength)) then {
    if (_speed >= 0) then {
        _velocity = _velocity1 vectorMultiply GVAR(vicBoxLength);
    } else {
        _velocity = _velocity1 vectorMultiply -GVAR(vicBoxLength);
    };
};
_speed = vectorMagnitude _velocity;

_velocity params ["_x", "_y", "_z"];

private _betweenTwoPointsOfCircle = {
    params ["_a", "_b"];

    private _cMagnitude = ((vectorMagnitude _a) + (vectorMagnitude _b)) / 2;

    (vectorNormalized (vectorLinearConversion [0, 1, 0.5, _a, _b, true])) vectorMultiply _cMagnitude
};

private _c1 = (vectorNormalized [
    -_y,
    -_x,
    if (_z == 0) then {0} else {2 * _x * _y / _z}
]) vectorMultiply -GVAR(vicBoxWidth);
private _c5 = _c1 vectorMultiply -1;
private _c3 = (vectorNormalized (_c1 vectorCrossProduct _velocity)) vectorMultiply -GVAR(vicBoxWidth);
private _c7 = _c3 vectorMultiply -1;
private _c2 = [_c1, _c3] call _betweenTwoPointsOfCircle;
private _c4 = [_c3, _c5] call _betweenTwoPointsOfCircle;
private _c6 = [_c5, _c7] call _betweenTwoPointsOfCircle;
private _c8 = [_c7, _c1] call _betweenTwoPointsOfCircle;

private _cArray = [_c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8];
// move the center point back by a bit
private _center  = (_vic modelToWorld [0, 0, 0])
    vectorAdd (_velocity1 vectorMultiply ( - GVAR(vicBoxWidth) / 2));

private _farAhead = _center vectorAdd _velocity;

private _fArray = _cArray apply {
    _center
        vectorAdd ((vectorLinearConversion [0, 1, GVAR(flyScareVelocitySpread), _velocity1, vectorNormalized _x, true]) vectorMultiply _speed)
        vectorAdd _x;
};

[
	_center,
	_cArray apply {_center vectorAdd _x},
	_farAhead,
	_fArray
]
