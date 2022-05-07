// this function aims to be for infantry what I presume the `getAimPrecision` command wants to be for vehicles.

/**
 * return value: value from 0..1 , with
 *  * 0 turned into opposite direction and
 *  * 1 aimed anywhere at object (FIRE geomatry)
 *  * 1 being aimed (point blank) on center of target
 */
params [
    ["_shooter", objNull, [objNull]],
    ["_target", objNull, [objNull]],
    ["_weaponOrWeaponVectorDir", "", ["", [0,0,0]]]
];

private _weaponVectorDir = _weaponOrWeaponVectorDir;
if (_weaponOrWeaponVectorDir isEqualType "") then {
    _weaponVectorDir = _shooter weaponDirection _weaponOrWeaponVectorDir;
};

private _intersectionsWithTarget = [_target, "FIRE"] intersect [getPos _shooter, (getPos _shooter) vectorAdd (_weaponVectorDir vectorMultiply 300)];
if (count _intersectionsWithTarget > 0) exitWith {1};

private _distanceVector = (getPosASL _target) vectorDiff (getPosASL _shooter);
private _aimingError = acos (_weaponVectorDir vectorCos _distanceVector);

private _aimingPrecision = (180 - _aimingError);

// this is all rather meh, but good enough atm

_aimingPrecision / 180
