#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (hasInterface) then {
        [] call FUNC(setupZeusModules);
    };
}] call CBA_fnc_addEventHandler;
