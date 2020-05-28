#include "..\..\component.hpp"

params [
    ["_gesturer", objNull]
];

assert(!isNull _gesturer);

private _potentialObservers = nearestObjects [_gesturer, ["Man"], 100];

_potentialObservers = _potentialObservers + (nearestObjects [_gesturer, ["Car"], 200] apply { driver _x });

INFO_1("%1 people & cars are near gesturer", count _potentialObservers);

// select civs
private _triggeredObserverCount = count (_potentialObservers select {
    (side _x) == civilian
} select {
    [_gesturer, vectorDirVisual _gesturer, _x] call FUNC(feelsAddressedByGesture)
} select {
    [QGVAR(gestured_at_stop), [_x], _x] call CBA_fnc_targetEvent;
    true
});

INFO_1("%1 civs were triggered for being gestured with 'stop'", _triggeredObserverCount);
