#include "..\script_component.hpp"
#define SEND_RADIUS 10

params [
    ["_gesturer", objNull]
];

assert(!isNull _gesturer);

// NOTE do NOT target units on foot - those are handled by ACE!
private _potentialObservers = nearestObjects [_gesturer, ["Car"], 200] apply { driver _x };

INFO_1("%1 cars with driver are near gesturer", count _potentialObservers);

// select civs
private _observers = _potentialObservers select {
    (side _x) == civilian
} select {

    [_gesturer, vectorDirVisual _gesturer, _x] call FUNC(feelsAddressedByGesture)
    || (_gesturer distance _x < SEND_RADIUS) /* HACK: as this is also triggered by ACE interact "go away", we need to disregard direction when very close*/
};

private _vectorDir = vectorDirVisual _gesturer;

{
    private _reverseTargetPos = (getPos _x) vectorAdd (_vectorDir vectorMultiply 50);
    [_target, _reverseTargetPos] call EFUNC(activities,doReverse);
} forEach _observers;

INFO_1("%1 civs were triggered for being gestured with 'go'", count _observers);
