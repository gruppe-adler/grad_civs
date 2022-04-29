#include "..\script_component.hpp"

private _playerUnit = call CBA_fnc_currentUnit;
private _playerPos = getPosASL _playerUnit;
private _playerVelocity = velocity _playerUnit;
private _speed = vectorMagnitude _playerVelocity;
if (_speed < 4) then { // amplify low values to have usable honking effect distances at low speeds
    if (_speed >= 0) then {
        _playerVelocity = (vectorDir _playerUnit) vectorMultiply 4;
    } else {
        _playerVelocity = (vectorDir _playerUnit) vectorMultiply -3;
    };
};

//    * if player is on a road
//      * civs assume player will *stay* on the road - they will not flee from non-road positions
//      * if speed is low, civ assumes hard (road) curving to be possible
//        -> polygon will open with ~45° to the side (tan is about 1)
//      * if speed is high, polygon will open ~11° to the side (tan is about 0.20)
//    * if player is NOT on a road  polygon will open ~15° to the side (tan is about 0.25)

private _playerIsOnRoad = isOnRoad _playerUnit;
private _narrowingFactor = 0.25;
if (_playerIsOnRoad) then {
     _narrowingFactor = linearConversion [4, 25, vectorMagnitude _playerVelocity, 1, 0.20, true];
};

private _leftVector = [ -(_playerVelocity#1), _playerVelocity#0, _playerVelocity#2] vectorMultiply _narrowingFactor;
private _rightVector = [_playerVelocity#1, -(_playerVelocity#0), _playerVelocity#2] vectorMultiply _narrowingFactor;
private _widestLeft = (_playerVelocity vectorAdd _leftVector) vectorMultiply 3;
private _widestRight = (_playerVelocity vectorAdd _rightVector) vectorMultiply 3;

private _playerNormal = vectorNormalized _playerVelocity;
private _3mLeft = [ -(_playerNormal#1), _playerNormal#0, _playerNormal#2] vectorMultiply 3;
private _3mRight = [_playerNormal#1, -(_playerNormal#0), _playerNormal#2] vectorMultiply 3;

private _dangerPoly = [
    _playerPos vectorAdd _3mLeft,
    _playerPos vectorAdd _widestLeft,
    _playerPos vectorAdd  _widestRight,
    _playerPos vectorAdd _3mRight
];

private _dangerPolyInPlayerHeight = _dangerPoly apply {
    [_x#0, _x#1, _playerPos#2]
};

private _nearMen = _vic nearEntities [["Man"], 200];
private _globalCivs = [] call EFUNC(lifecycle,getGlobalCivs);
private _nearCivs = _nearMen arrayIntersect (_globalCivs + (ALL_HUMAN_PLAYERS select {(side _x) == civilian}));
{
    private _civPos = getPosASL _x;
    private _civPosInPlayerHeight = [_civPos#0, _civPos#1, _playerPos#2];
    if (isOnRoad _civPos || !_playerIsOnRoad) then {
        if (_civPosInPlayerHeight inPolygon _dangerPolyInPlayerHeight) then {
            [QGVAR(honked_at), [_x, _playerPos, _playerVelocity], [_x]] call CBA_fnc_targetEvent;
        };
    };
} forEach _nearCivs;

[QGVAR(honking_at_poly), _dangerPolyInPlayerHeight] call CBA_fnc_localEvent;
