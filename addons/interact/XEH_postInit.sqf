#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (hasInterface) then {
    call FUNC(aceInteractWrapper);
    call FUNC(addCivInteractions);

    [{
        if (!isGameFocused || isGamePaused) exitWith {};
        [] call FUNC(checkWeaponOnCivilianPointer);
    }, 0.5, []] call CBA_fnc_addPerFrameHandler;

    ACE_player addEventHandler ["GetInMan", FUNC(vehicleSeatHandler)];
    ACE_player addEventHandler ["SeatSwitchedMan", FUNC(vehicleSeatHandler)];
    ACE_player addEventHandler ["GetOutMan", FUNC(vehicleSeatHandler)];
    [] call FUNC(vehicleSeatHandler);
};

[] call FUNC(addInteractEventHandlers);

if (isServer || CBA_isHeadlessClient) then {
    ["activities", ["act_business"], FUNC(sm_activities)] call EFUNC(common,augmentStateMachine);
};
