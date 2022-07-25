#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (!(GVAR(enabled))) exitWith {};

    if (hasInterface) then {
        player addEventHandler ["GetInMan", FUNC(onGetInMan)];
        player addEventHandler ["GetOutMan", FUNC(onGetOutMan)];
        player addEventHandler ["SeatSwitchedMan", FUNC(onSeatSwitchedMan)];
    };
}] call CBA_fnc_addEventHandler;
