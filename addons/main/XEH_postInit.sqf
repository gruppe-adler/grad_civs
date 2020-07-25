#include "script_component.hpp"


if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

INFO_3("I am a player: %1 | HC: %2 | Server: %3", hasInterface, CBA_isHeadlessClient, isServer);
