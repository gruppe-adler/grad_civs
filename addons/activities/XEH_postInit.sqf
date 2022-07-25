#include "script_component.hpp"

["CBA_SettingsInitialized", {
	if (!(EGVAR(main,enabled))) exitWith {};

	[] call FUNC(initCommonEventhandlers);

	if (isServer || CBA_isHeadlessClient) then {
		["lifecycle", ["lfc_life"], FUNC(sm_emotions)] call EFUNC(common,augmentStateMachine);
		["lifecycle", ["lfc_life"], FUNC(sm_activities)] call EFUNC(common,augmentStateMachine);
		[
			QEGVAR(lifecycle,civ_added), 
			{
				{
					[_x] call FUNC(onCivAdded);			
				} forEach _this;
			}
		] call CBA_fnc_addEventHandler;
	};
}] call CBA_fnc_addEventHandler;
