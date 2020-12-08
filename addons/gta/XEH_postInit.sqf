#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [QEGVAR(common,civ_added), FUNC(onCivAdded)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ACE_player addEventHandler ["GetInMan", FUNC(onGetInMan)];
    ACE_player addEventHandler ["GetOutMan", FUNC(onGetOutMan)];
    ACE_player addEventHandler ["GetOutMan", FUNC(onSeatSwitchedMan)];
};
