#include "..\script_component.hpp"

{
    INFO_1("%1 will stop until told otherwise", _x);
    [_x] call EFUNC(activities,doStop);
} forEach (_objects call FUNC(selectGradCivs))
