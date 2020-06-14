#include "..\script_component.hpp"

if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then {
    _this setVariable ["grad_civs_currentlyThinking", nil, true];
};
