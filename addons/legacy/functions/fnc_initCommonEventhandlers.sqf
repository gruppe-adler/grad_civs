#include "..\script_component.hpp"

[QGVAR(switchMove), {
        params ["_unit", "_animation"];
        _unit switchMove _animation;
    }
] call CBA_fnc_addEventHandler;

[QGVAR(doStop), FUNC(doStop)] call CBA_fnc_addEventHandler;
[QGVAR(doCarryOn), FUNC(doCarryOn)] call CBA_fnc_addEventHandler;
[QGVAR(doReverse), FUNC(doReverse)] call CBA_fnc_addEventHandler;
