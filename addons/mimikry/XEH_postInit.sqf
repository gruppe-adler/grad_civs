#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (!(GVAR(enabled))) exitWith {
    INFO("module disabled. good bye.");
};

if (isServer) then {
    INFO("server init running...");
    GVAR(INFOCHANNEL) = [] call FUNC(createInfoChannel);
    publicVariable QGVAR(INFOCHANNEL);
};

if (hasInterface) then {
    ISNILS(GVAR(INFOCHANNEL), 0);
    [] call FUNC(addEventHandlers);


    GVAR(PLAYERSIDE) = sideUnknown;
    [
        {
            if (!isGameFocused || isGamePaused) exitWith {};
            if !(alive player) exitWith {};
            if (GVAR(PLAYERSIDE) == side player) exitWith {};
            if ((["HEALTHY", "INJURED"] find (lifeState player)) == -1) exitWith {};

            if (side player == civilian) then {
                GVAR(INFOCHANNEL) radioChannelAdd [player];
                ["you are CIVILIAN now"] call FUNC(showCivHint);
            } else { if (GVAR(PLAYERSIDE) == civilian) then {
                ["you are NO LONGER CIVILIAN"] call FUNC(showCivHint);
                GVAR(INFOCHANNEL) radioChannelRemove [player];
            }};
            GVAR(PLAYERSIDE) = side player;
        },
        5,
        []
    ] call CBA_fnc_addPerFrameHandler;

};
