#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

if (hasInterface) then {
    call FUNC(aceInteractWrapper);
    call FUNC(addInteractEventHandlers);
    call FUNC(addCivInteractions);


    [{
        if (!isGameFocused || isGamePaused) exitWith {};
        [] call FUNC(checkWeaponOnCivilianPointer);
    }, 0.5, []] call CBA_fnc_addPerFrameHandler;

    [{
        if (!isGameFocused || isGamePaused) exitWith {};
        if ([] call FUNC(isPlayerHonking)) then {
            [] call FUNC(checkHonkingOnCivilian);
        };
    }, 0.1, []] call CBA_fnc_addPerFrameHandler;


};
