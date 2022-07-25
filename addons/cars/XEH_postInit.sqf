#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (isServer || CBA_isHeadlessClient) then {
        ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
    };
}] call CBA_fnc_addEventHandler;
