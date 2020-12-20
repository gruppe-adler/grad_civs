#include "..\script_component.hpp"

GVAR(showWhatTheyThink_civ_added) = [
	QEGVAR(lifecycle,civ_added),
	{
		if (!GVAR(showPinkArrows)) exitWith {};
		SCRIPT("showWhatTheyThink_civ_added");
		{
			private _civ = _x;
			private _arrow = createSimpleObject ["Sign_Arrow_Large_Pink_F", [0, 0, 0]];
			_arrow attachTo [_civ, [0, 0, 5]];
		} forEach _this;
	}
] call CBA_fnc_addEventHandler;

GVAR(showWhatTheyThinkciv_removed) = [
	QEGVAR(lifecycle,civ_removed),
	{
		SCRIPT("showWhatTheyThink_civ_removed");
		{
			private _civ = _x;
			{
				deleteVehicle _x;
			} forEach (attachedObjects _civ);
		} forEach _this;
	}
] call CBA_fnc_addEventHandler;
