#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
    [QEGVAR(lifecycle,civ_added), FUNC(onCivAdded)] call CBA_fnc_addEventHandler;
};
