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


    GVAR(playerActsAsCiv) = false;
    [
        {
            if (!isGameFocused || isGamePaused) exitWith {};
            if !(alive player) exitWith {};
            if !((lifeState player) in ["HEALTHY", "INJURED"]) exitWith {}; // NOTE: incapacitated players are side civ

            private _playerIsCiv = side player == civilian;

            if (GVAR(playerActsAsCiv) == _playerIsCiv) exitWith {};
            
            if (_playerIsCiv) then {
                GVAR(INFOCHANNEL) radioChannelAdd [player];
                ["you are CIVILIAN now"] call FUNC(showCivHint);
            } else { if (GVAR(playerActsAsCiv)) then {
                ["you are NO LONGER CIVILIAN"] call FUNC(showCivHint);
                GVAR(INFOCHANNEL) radioChannelRemove [player];
            }};
            GVAR(playerActsAsCiv) = _playerIsCiv;
        },
        5,
        []
    ] call CBA_fnc_addPerFrameHandler;

};
