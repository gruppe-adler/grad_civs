#include "..\script_component.hpp"

{
    INFO_1("%1 will carry on with whatever", _x);
    [_x] call EFUNC(legacy,doCarryOn);
} forEach (_objects call FUNC(selectGradCivs))
