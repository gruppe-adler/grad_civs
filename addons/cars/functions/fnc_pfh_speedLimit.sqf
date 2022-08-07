#include "..\script_component.hpp"

private _speedLimits = call FUNC(determineSpeedLimits);

{
    _x setVariable [QGVAR(speedLimit), GVAR(globalSpeedLimit)];
} forEach GVAR(localCars);

{
    _x params ["_location", "_speedLimit"];
    private _affectedCars = GVAR(localCars) inAreaArray _location;
    {
        _x setVariable [QGVAR(speedLimit), _speedLimit];
    } forEach _affectedCars;
} forEach _speedLimits;

{
    _x limitSpeed (_x getVariable [QGVAR(speedLimit), GVAR(globalSpeedLimit)]);
} forEach GVAR(localCars);
