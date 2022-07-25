#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    [QGVAR(switchMove), {
            params ["_unit", "_animation"];
            _unit switchMove _animation;
        }
    ] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;
