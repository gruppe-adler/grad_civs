#include "..\script_component.hpp"

private _maxTravelRadius = GVAR(maxTravelRadius);
private _minTravelRadius = GVAR(maxTravelRadius) / 2;
if (_maxTravelRadius <= 0) then {
    private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
    _minTravelRadius = _vehicleSpawnDistances#0;
    _maxTravelRadius = _vehicleSpawnDistances#1;
};

[
    getPos _this,
    [true, false, false],
    [_minTravelRadius, _maxTravelRadius],
    [0, 360],
    "car",
    [
        {
            params ["_error", "_path", "_civ"];
            if ("_error" != "") exitWith {
                WARNING_2("could not find path for %1 : %2", _civ, _error);
            };

            private _currentState = [_civ, "business"] call EFUNC(common,civGetState);
            if (_currentState != "bus_voyage") exitWith {
                INFO_2("discarding path - civ %1 is not in voyage state anymore but in %2", _civ, _currentState);
            };

            private _group = group _civ;

            private _reversePath = reverse (+_path);

            [_group] call CBA_fnc_clearWaypoints;
            [_group, _reversePath#0] call EFUNC(legacy,taskPatrolAddWaypoint);

            // add home waypoint!
            private _home = _group getVariable ["grad_civs_home", objNull];
            if (!isNull _home) then {
                LOG_1("adding home wp at %1", getPos _home);
                [_group, getPos _home, [0, 15, 30], 20] call EFUNC(legacy,taskPatrolAddWaypoint);
            };
            LOG("adding cycle wp close by group position");
            // NOTE : a cycle waypoint points to the *closest waypoint other than the previous one*! which means in our case: close to the initial waypoint
            [_group, _position vectorAdd [10, 0, 0]] call EFUNC(legacy,addCycleWaypoint);

            LOG_2("taskPatrol end. waypoints for group %1 : %2", _group, count waypoints _group);


            _civ setSpeedMode "LIMITED";
            _civ forceSpeed -1;
            _civ enableDynamicSimulation true;
            _civ doFollow _civ;
        },
        [_this]
    ]
] call EFUNC(movement,api_generateDestination);
