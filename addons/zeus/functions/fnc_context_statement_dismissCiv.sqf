#include "..\script_component.hpp"

{
    INFO_1("%1 is being dismissed from GRAD Civilians", _x);
    [_x] call EFUNC(lifecycle,dismissCiv);
} forEach (_objects call FUNC(selectGradCivs))
