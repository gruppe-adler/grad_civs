#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (!(GVAR(enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [QEGVAR(common,civ_added), FUNC(onCivAdded)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    player addEventHandler ["GetInMan", FUNC(onGetInMan)];
    player addEventHandler ["GetOutMan", FUNC(onGetOutMan)];
    player addEventHandler ["SeatSwitchedMan", FUNC(onSeatSwitchedMan)];
};
