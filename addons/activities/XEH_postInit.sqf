#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

[] call FUNC(initCommonEventhandlers);

if (isServer || CBA_isHeadlessClient) then {
	["lifecycle", ["lfc_life"], FUNC(sm_emotions)] call EFUNC(common,augmentStateMachine);
	["lifecycle", ["lfc_life"], FUNC(sm_activities)] call EFUNC(common,augmentStateMachine);
	[QEGVAR(lifecycle,civ_added), FUNC(onCivAdded)] call CBA_fnc_addEventHandler;
};
