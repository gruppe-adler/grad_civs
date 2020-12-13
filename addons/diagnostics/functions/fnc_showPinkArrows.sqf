#include "..\script_component.hpp"

GVAR(showWhatTheyThink_civ_added) = [
	QEGVAR(lifecycle,civ_added),
	{
		if (!GVAR(showPinkArrows)) exitWith {};
		params [["_civ", objNull, [objNull]]];
		SCRIPT("showWhatTheyThink_civ_added");
		private _arrow = createSimpleObject ["Sign_Arrow_Large_Pink_F", [0, 0, 0]];
		_arrow attachTo [_civ, [0, 0, 5]];
	}
] call CBA_fnc_addEventHandler;

GVAR(showWhatTheyThinkciv_removed) = [
	QEGVAR(lifecycle,civ_removed),
	{
		params [["_civ", objNull, [objNull]]];
		SCRIPT("showWhatTheyThink_civ_removed");
		{
			deleteVehicle _x;
		} forEach (attachedObjects _civ);
	}
] call CBA_fnc_addEventHandler;
