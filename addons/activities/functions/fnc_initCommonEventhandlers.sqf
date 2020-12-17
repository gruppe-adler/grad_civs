#include "..\script_component.hpp"

["ace_unconscious", FUNC(handleAceUnconscious)] call CBA_fnc_addEventHandler;

[QGVAR(doStop), FUNC(doStop)] call CBA_fnc_addEventHandler;
[QGVAR(doCarryOn), FUNC(doCarryOn)] call CBA_fnc_addEventHandler;
[QGVAR(doReverse), FUNC(doReverse)] call CBA_fnc_addEventHandler;
