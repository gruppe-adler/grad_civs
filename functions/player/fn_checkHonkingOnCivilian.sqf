#include "..\..\component.hpp"

private _playerPos = getPosATL player;
private _nearCivs = (_playerPos nearEntities [["Man"], 200]) arrayIntersect ([] call GRAD_CIVS_fnc_getGlobalCivs);

if (!GRAD_CIVS_DEBUG_CIVSTATE && (count _nearCivs) == 0) exitWith {};

private _playerVelocity = velocity player;
private _speed = vectorMagnitude _playerVelocity;
if (_speed < 4) then {
    if (_speed >= 0) then {
        _playerVelocity = (vectorDir player) vectorMultiply 4;
    } else {
        _playerVelocity = (vectorDir player) vectorMultiply -3;
    };
};

//    * if player is on a road
//      * civs assume player will *stay* on the road - they will not flee from non-road positions
//      * if speed is low, civ assumes hard (road) curving to be possible -> polygon will open with ~45° to the side (tan is about 1)
//      * if speed is high, polygon will open ~11° to the side (tan is about 0.20)
//    * if player is NOT on a road  polygon will open ~15° to the side (tan is about 0.25)

private _playerIsOnRoad = isOnRoad player;
private _narrowingFactor = 0.25;
if (_playerIsOnRoad) then {
     _narrowingFactor = linearConversion [4, 25, vectorMagnitude _playerVelocity, 1, 0.20, true];
};

private _leftVector = [ -(_playerVelocity select 1), _playerVelocity select 0, _playerVelocity select 2] vectorMultiply _narrowingFactor;
private _rightVector = [_playerVelocity select 1, -(_playerVelocity select 0), _playerVelocity select 2] vectorMultiply _narrowingFactor;
private _widestLeft = (_playerVelocity vectorAdd _leftVector) vectorMultiply 3;
private _widestRight = (_playerVelocity vectorAdd _rightVector) vectorMultiply 3;

private _playerNormal = vectorNormalized _playerVelocity;
private _5mLeft = [ -(_playerNormal select 1), _playerNormal select 0, _playerNormal select 2] vectorMultiply 3;
private _5mRight = [_playerNormal select 1, -(_playerNormal select 0), _playerNormal select 2] vectorMultiply 3;

private _dangerPoly = [_playerPos vectorAdd _5mLeft, _playerPos vectorAdd _widestLeft, _playerPos vectorAdd  _widestRight, _playerPos vectorAdd _5mRight];

private _dangerPolyInPlayerHeight = _dangerPoly apply {
    [_x select 0, _x select 1, _playerPos select 2]
};

if (GRAD_CIVS_DEBUG_CIVSTATE) then {
    player setVariable ["grad_civs_dangerPolyInPlayerHeight", _dangerPolyInPlayerHeight];
};

{
    private _civPos = getPosATL _x;
    private _civPosInPlayerHeight = [_civPos select 0, _civPos select 1, _playerPos select 2];
    if (isOnRoad _civPos || !_playerIsOnRoad) then {
        if (_civPosInPlayerHeight inPolygon _dangerPolyInPlayerHeight) then {
            ["honked_at", [_x, _playerPos, _playerVelocity], [_x]] call CBA_fnc_targetEvent;
        };
    };
} forEach _nearCivs;
