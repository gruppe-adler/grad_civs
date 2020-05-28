#include "..\..\component.hpp"

params ["_unit", "_animation"];

systemChat format["_animation: %1", _animation];

if ((toLower _animation) in ["gesturefreeze", "ace_gestures_hold", "ace_gestures_holdstandlowered"]) then {
    [_unit] call FUNC(handleStopGesture);
};
