#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {
        INFO("GRAD civs is disabled. Good bye!");
    };

    INFO_3("I am a player: %1 | HC: %2 | Server: %3", hasInterface, CBA_isHeadlessClient, isServer);
}] call CBA_fnc_addEventHandler;
