#include "..\script_component.hpp"

private _maxTravelRadius = GVAR(maxTravelRadius);
if (_maxTravelRadius <= 0) then {
    private _vehicleSpawnDistances = [GVAR(spawnDistancesInVehicles)] call EFUNC(common,parseCsv);
    _maxTravelRadius = _vehicleSpawnDistances#1;
};

[_this, _this, _maxTravelRadius, 3, [0,0,0], false, true] call EFUNC(patrol,taskPatrol); // vehicle patrol: wide range
_this setSpeedMode "LIMITED";
_this forceSpeed -1;
_this enableDynamicSimulation true;
_this doFollow _this;
