#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (!(GVAR(enabled))) exitWith {
        INFO("module disabled. good bye.");
    };

    if (hasInterface) then {
        [] call FUNC(addEventHandlers);

        GVAR(playerActsAsCiv) = false;
        [
            {
                if (!isGameFocused || isGamePaused) exitWith {};
                private _playerUnit = call CBA_fnc_currentUnit;
                if !(alive _playerUnit) exitWith {};
                private _playerIsCiv = false;
                private _playerIsCiv = (side _playerUnit) isEqualTo civilian;
                if !((lifeState _playerUnit) in ["HEALTHY", "INJURED"]) then {
                    // NOTE: incapacitated players are side civ which we dont want
                    _playerIsCiv = false;
                };

                if (GVAR(playerActsAsCiv) isEqualTo _playerIsCiv) exitWith {};

                if (_playerIsCiv) then {
                    ["you are CIVILIAN now"] call FUNC(showCivHint);
                } else { if (GVAR(playerActsAsCiv)) then {
                    ["you are NO LONGER CIVILIAN"] call FUNC(showCivHint);
                }};
                GVAR(playerActsAsCiv) = _playerIsCiv;
            },
            5,
            []
        ] call CBA_fnc_addPerFrameHandler;

    };
}] call CBA_fnc_addEventHandler;
