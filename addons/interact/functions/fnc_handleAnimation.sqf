#include "..\script_component.hpp"

params ["_unit", "_animation"];

LOG_2("handling unit %1 animation %2", _unit, _animation);

if ((toLower _animation) in ["gesturefreeze", "ace_gestures_hold", "ace_gestures_holdstandlowered"]) exitWith {
    [_unit] call FUNC(handleGestureStop);
};

if ((toLower _animation) in ["gesturegob", "gesturego"]) exitWith {
    // see https://github.com/acemod/ACE3/blob/f3f57c6/addons/gestures/CfgVehicles.hpp#L22
    [_unit] call FUNC(handleGestureGo);
};
