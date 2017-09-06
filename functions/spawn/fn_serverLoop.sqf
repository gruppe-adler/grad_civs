#include "..\..\component.hpp"

if (!isServer) exitWith {};

private _mainLoop = {
    params ["_args", "_handle"];

    if (call GRAD_CIVS_EXITON) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    _allPlayers = (call CBA_fnc_players);

    if (GRAD_CIVS_ENABLEDONFOOT) then {
        if (GRAD_CIVS_ONFOOTCOUNT < GRAD_CIVS_MAXCIVSONFOOT) then {

            LOGTIME_START("findSpawnPos_onFoot");
            _pos = [
            	_allPlayers,
            	GRAD_CIVS_SPAWNDISTANCEONFOOTMIN,
            	GRAD_CIVS_SPAWNDISTANCEONFOOTMAX,
            	GRAD_CIVS_ONFOOTUNITS
            ] call grad_civs_fnc_findSpawnPosition;
            LOGTIME_END("findSpawnPos_onFoot");

            if (_pos isEqualTo [0,0,0]) exitWith {};

            LOGTIME_START("spawnCiv_onFoot");
        	_unit = [_pos] call grad_civs_fnc_spawnCivilian;
            LOGTIME_END("spawnCiv_onFoot");

            GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT + 1;
            GRAD_CIVS_ONFOOTUNITS pushBack _unit;
            if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_ONFOOTUNITS"; publicVariable "GRAD_CIVS_ONFOOTCOUNT"};

            [_unit,_pos,400 - (random 300),[3,6],[0,2,10],true] spawn grad_civs_fnc_taskPatrol;
        };

        LOGTIME_START("cleanup_onFoot");
        [_allPlayers,"onfoot"] call grad_civs_fnc_cleanup;
        LOGTIME_END("cleanup_onFoot");
    };

    if (GRAD_CIVS_ENABLEDINVEHICLES) then {
        if (GRAD_CIVS_INVEHICLESCOUNT < GRAD_CIVS_MAXCIVSINVEHICLES) then {

            LOGTIME_START("findSpawnPos_vehicle");
            _pos = [
            	_allPlayers,
            	GRAD_CIVS_SPAWNDISTANCEINVEHICLESMIN,
            	GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX,
            	GRAD_CIVS_INVEHICLESUNITS
            ] call grad_civs_fnc_findSpawnPosition;
            LOGTIME_END("findSpawnPos_vehicle");

            if (_pos isEqualTo [0,0,0]) exitWith {};

            LOGTIME_START("spawnCiv_vehicle");
            _veh = [_pos,selectRandom GRAD_CIVS_VEHICLES] call grad_civs_fnc_spawnVehicle;
            _unit = [_pos] call grad_civs_fnc_spawnCivilian;
            _unit assignAsDriver _veh;
            _unit moveinAny _veh;
            (group _unit) setSpeedMode "NORMAL";
            LOGTIME_END("spawnCiv_vehicle");

            [_unit,_pos,2500,3,[0,0,0],false,true] spawn grad_civs_fnc_taskPatrol;

            GRAD_CIVS_INVEHICLESCOUNT = GRAD_CIVS_INVEHICLESCOUNT + 1;
            GRAD_CIVS_INVEHICLESUNITS pushBack _unit;
            if (GRAD_CIVS_DEBUGMODE) then {publicVariable "GRAD_CIVS_INVEHICLESUNITS"; publicVariable "GRAD_CIVS_INVEHICLESCOUNT"};
        };
        LOGTIME_START("cleanup_vehicle");
        [_allPlayers,"invehicles"] call grad_civs_fnc_cleanup;
        LOGTIME_END("cleanup_vehicle");
    };
};

grad_civs_mainLoop = [_mainLoop,10,[]] call CBA_fnc_addPerFrameHandler;
