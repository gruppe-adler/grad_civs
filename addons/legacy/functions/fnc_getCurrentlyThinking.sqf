#include "..\script_component.hpp"

if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then {
    _this getVariable ["grad_civs_currentlyThinking", "dumdidum"];
} else {
    ""
};
