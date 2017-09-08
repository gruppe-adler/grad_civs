#include "..\..\component.hpp"

if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn grad_civs_fnc_populateArea};
if (isNil "GRAD_CIVS_ONFOOTUNITS") exitWith {ERROR("grad-civs has not been initialized.")};

params ["_area",["_amount",20]];

private _areas = if (_area isEqualType objNull) then {synchronizedObjects _area} else {[_area]};
private _maxLoops = _amount * 5;
{
    _amountSpawned = 0;
    for [{_i=0},{_i<1000},{_i=_i+1}] do {

        _spawnPos = [_x] call grad_civs_fnc_findRandomPosArea;
        if (count _spawnPos > 0) then {
            _civ = [_spawnPos] call grad_civs_fnc_spawnCivilian;
            _civ setVariable ["grad_civs_excludeFromCleanup",true];
            GRAD_CIVS_ONFOOTUNITS pushBack _civ;
            GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT + 1;
            [_civ,_spawnPos,300 - (random 250),[3,6],[0,2,10],true] spawn grad_civs_fnc_taskPatrol;
            _amountSpawned = _amountSpawned + 1;
        };

        if (_amountSpawned >= _amount) exitWith {};
        if (_i > _maxLoops) exitWith {};
    };

    _vehAmount = if (_x isEqualType objNull) then {
        (triggerArea _x) params [["_a",0],["_b",0]];
        [getPos _x,_a max _b,1,30,15] call grad_civs_fnc_createSideRoadVehicles
    } else {
        _x params ["_center",["_a",0],["_b",0]];
        [_center,_a max _b,1,1,15] call grad_civs_fnc_createSideRoadVehicles
    };

    INFO_2("Populated area with %1 civilians and %2 static cars.",_amountSpawned,_vehAmount);

    false
} count _areas;
