#include "..\..\component.hpp"

params [
    ["_gesturer", objNull]
];

assert(!isNull _gesturer);

private _potentialObservers = nearestObjects [_gesturer, ["Man"], 100];

// select civs
private _triggeredObserverCount = count (_potentialObservers select {
    (side _x) == civilian
} select {
    [_gesturer, vectorDirVisual _gesturer, _x] call FUNC(feelsAddressedByGesture)
} apply {
    [QGVAR(gestured_at_stop), [_x], _x] call CBA_fnc_targetEvent;
});

INFO("%1 civs were triggered for being gestured at", _triggeredObserverCount);
