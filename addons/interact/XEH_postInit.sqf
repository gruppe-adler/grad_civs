#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (hasInterface) then {
    call FUNC(aceInteractWrapper);
    call FUNC(addCivInteractions);

    [{
        if (!isGameFocused || isGamePaused) exitWith {};
        [] call FUNC(checkWeaponOnCivilianPointer);
    }, 0.5, []] call CBA_fnc_addPerFrameHandler;
    private _playerUnit = call CBA_fnc_currentUnit;
    _playerUnit addEventHandler ["GetInMan", FUNC(vehicleSeatHandler)];
    _playerUnit addEventHandler ["SeatSwitchedMan", FUNC(vehicleSeatHandler)];
    _playerUnit addEventHandler ["GetOutMan", FUNC(vehicleSeatHandler)];
    _playerUnit addEventHandler ["Killed", { FUNC(vehicleSeatHandler) }];
    _playerUnit addEventHandler ["Respawn", { FUNC(vehicleSeatHandler) }];
    [] call FUNC(vehicleSeatHandler);
};

[] call FUNC(addInteractEventHandlers);

if (isServer || CBA_isHeadlessClient) then {
    ["activities", ["act_business"], FUNC(sm_activities)] call EFUNC(common,augmentStateMachine);
};
