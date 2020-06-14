#include "..\script_component.hpp"

params [
    ["_gesturer", objNull],
    ["_gesturingVector", []],
    ["_unit", objNull]
];

assert(!isNull _gesturer);
assert(!isNull _unit);

if ((_gesturer distance _unit) > 100) exitWith {false};

private _distanceVector = (getPosASL _unit) vectorDiff (getPosASL _gesturer);
private _distanceVector2D = [_distanceVector#0, _distanceVector#1, 0];
private _gestureAngleTowardsUnit = acos (_gesturingVector vectorCos _distanceVector2D);

if (_gestureAngleTowardsUnit >= 11) exitWith {false};

private _unitEyesVector = eyeDirection _unit;

private _gesturerAngleFromUnit = acos (_unitEyesVector vectorCos (_distanceVector2D vectorMultiply -1));

if (_gesturerAngleFromUnit > 70) exitWith {false};

// NOTE: `checkVisibility` will in some vehicles return 0 when looking from a driver seat,
//       for example in "C_Van_01_fuel_F".
//       As a workaround, check visibility from 1m in front of a driver.
private _eyePos = eyePos _unit;
if (vehicle _unit != _unit) then {
    _eyePos = (eyePos _unit) vectorAdd (vectorDirVisual _unit)
};

(([objNull, "VIEW"] checkVisibility [eyePos _gesturer, _eyePos]) > 0.5)

// ENHANCEMENT NOTE also, this could be dependent on distance.
// I'm standing next to you, you will see me gesturing at you even if you're turned 90deg on me.
// I'm a hundred meters away, you'll ignore me if I'm in your preipheral vision only.
