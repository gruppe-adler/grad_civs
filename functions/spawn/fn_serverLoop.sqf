#include "..\..\component.hpp"

if (!isServer) exitWith {};

private _mainLoop = {
    params ["_args", "_handle"];

    if (call GRAD_CIVS_EXITON) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    _playerPositions = [] call grad_civs_fnc_getPlayerPositions;

    if (GRAD_CIVS_ENABLEDONFOOT) then {
        if (GRAD_CIVS_ONFOOTCOUNT < GRAD_CIVS_MAXCIVSONFOOT) then {
            _pos = [
            	_playerPositions,
            	GRAD_CIVS_SPAWNDISTANCEONFOOTMIN,
            	GRAD_CIVS_SPAWNDISTANCEONFOOTMAX,
            	GRAD_CIVS_ONFOOTUNITS
            ] call grad_civs_fnc_findSpawnPosition;

            if (_pos isEqualTo [0,0,0]) exitWith {};

        	_unit = [_pos] call grad_civs_fnc_spawnCivilian;

            GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT + 1;
            GRAD_CIVS_ONFOOTUNITS = GRAD_CIVS_ONFOOTUNITS + [_unit];
            if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_ONFOOTUNITS"; publicVariable "GRAD_CIVS_ONFOOTCOUNT"};

            [_unit, _pos, 400 - (random 300), [3,6], [0,2,10]] call grad_civs_fnc_taskPatrol;
        };
        [_playerPositions,"onfoot"] call grad_civs_fnc_cleanup;
    };

    if (GRAD_CIVS_ENABLEDINVEHICLES) then {
        if (GRAD_CIVS_INVEHICLESCOUNT < GRAD_CIVS_MAXCIVSINVEHICLES) then {
            _pos = [
            	_playerPositions,
            	GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN,
            	GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX,
            	GRAD_CIVS_INVEHICLESUNITS
            ] call grad_civs_fnc_findSpawnPosition;

            if (_pos isEqualTo [0,0,0]) exitWith {};

            _veh = [_pos,selectRandom GRAD_CIVS_VEHICLES] call grad_civs_fnc_spawnVehicle;
            _unit = [_pos] call grad_civs_fnc_spawnCivilian;
            _unit moveinAny _veh;

            GRAD_CIVS_INVEHICLESCOUNT = GRAD_CIVS_INVEHICLESCOUNT + 1;
            GRAD_CIVS_INVEHICLESUNITS = GRAD_CIVS_INVEHICLESUNITS + [_unit];
            if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_INVEHICLESUNITS"; publicVariable "GRAD_CIVS_INVEHICLESCOUNT"};
        };
        [_playerPositions,"invehicles"] call grad_civs_fnc_cleanup;
    };
};

grad_civs_mainLoop = [_mainLoop,10,[]] call CBA_fnc_addPerFrameHandler;
