#include "..\script_component.hpp"

params [
    ["_gesturer", objNull]
];

assert(!isNull _gesturer);

private _potentialObservers = nearestObjects [_gesturer, ["Man"], 100];

_potentialObservers = _potentialObservers + (nearestObjects [_gesturer, ["Car"], 200] apply { driver _x });

INFO_1("%1 people & cars are near gesturer", count _potentialObservers);

// select civs
private _observers = _potentialObservers select {
    (side _x) == civilian
} select {
    [_gesturer, vectorDirVisual _gesturer, _x] call FUNC(feelsAddressedByGesture)
};

{
    private _recklessness = _x getVariable ["grad_civs_recklessness", 5];
    private _waitTime = linearConversion [0, 10, _recklessness, 60*15, 15, false];
    [_x, _waitTime] call FUNC(doStop);
} forEach _observers;

INFO_1("%1 civ observers were triggered for being gestured with 'stop'", count _observers);
