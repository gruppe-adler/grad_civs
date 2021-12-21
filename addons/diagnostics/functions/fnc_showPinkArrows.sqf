#include "..\script_component.hpp"

LOG_1("running showPinkArrows with %1 ", GVAR(showPinkArrows));

if (!GVAR(showPinkArrows)) exitWith {
	[QEGVAR(lifecycle,civ_added), GVAR(showWhatTheyThink_civ_added)] call CBA_fnc_removeEventHandler;
	[QEGVAR(lifecycle,civ_removed), GVAR(showWhatTheyThinkciv_removed)] call CBA_fnc_removeEventHandler;

	{
		[_x] call FUNC(showPinkArrows_arrowDelete);
	} forEach ([] call EFUNC(lifecycle,getGlobalCivs));
};

GVAR(showWhatTheyThink_civ_added) = [
	QEGVAR(lifecycle,civ_added),
	{
		{
			[_x] call FUNC(showPinkArrows_arrowEnsure);
		} forEach _this;
	}
] call CBA_fnc_addEventHandler;

GVAR(showWhatTheyThinkciv_removed) = [
	QEGVAR(lifecycle,civ_removed),
	{
		{
			[_x] call FUNC(showPinkArrows_arrowDelete);
		} forEach _this;
	}
] call CBA_fnc_addEventHandler;

{
	[_x] call FUNC(showPinkArrows_arrowEnsure);
} forEach ([] call EFUNC(lifecycle,getGlobalCivs));
