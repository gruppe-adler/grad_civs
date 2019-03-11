#include "..\..\component.hpp"

ASSERT_SERVER("populate area must be run on server or hc");
if (!canSuspend) exitWith {_this spawn grad_civs_fnc_populateArea};

params ["_area",["_amount",20],["_excludeFromCleanup",true],["_staticCars",false],["_staticCarsMax",20]];

private _areas = if (_area isEqualType objNull) then {synchronizedObjects _area} else {[_area]};
private _maxLoops = _amount * 5;
{
    _amountSpawned = 0;
    for [{_i=0},{_i<1000},{_i=_i+1}] do {

        _spawnPos = [_x] call grad_civs_fnc_findRandomPosArea;
        if (count _spawnPos > 0) then {
            _group = [_spawnPos, GRAD_CIVS_INITIALGROUPSIZE, objNull, "reside"] call grad_civs_fnc_spawnCivilianGroup;
            if (_excludeFromCleanup) then {
                {
                     _x setVariable ["grad_civs_excludeFromCleanup",true];
                 } forEach units _group;
            };
            _amountSpawned = _amountSpawned + (count units _group);
        };

        if (_amountSpawned >= _amount) exitWith {};
        if (_i > _maxLoops) exitWith {};
    };

    private _vehAmount = 0;
    if (_staticCars) then {
        _vehAmount = if (_x isEqualType objNull) then {
            (triggerArea _x) params [["_a",0],["_b",0]];
            [getPos _x,_a max _b,5,5,15,_staticCarsMax] call grad_civs_fnc_createSideRoadVehicles
        } else {
            _x params ["_center",["_a",0],["_b",0]];
            [_center,_a max _b,5,5,15,_staticCarsMax] call grad_civs_fnc_createSideRoadVehicles
        };
    };


    INFO_2("Populated area with %1 civilians and %2 static cars.",_amountSpawned,_vehAmount);

    false
} count _areas;
