#include "..\script_component.hpp"

params [
	["_display", -1, [-1]],
	["_control", -1, [-1]]
];

[
	{
		params ["_display"];
		!isNull (findDisplay _display)
	},
	{
		params ["_display", "_control"];
		private _eventType = "Draw";

		private _id = ((findDisplay _display) displayCtrl _control) ctrlAddEventHandler [_eventType, {
			if (!GVAR(showOnMap)) exitWith {};

			private _civs = [] call EFUNC(lifecycle,getGlobalCivs);
			private _civsInCarDrivers = _civs select {
				private _vec = vehicle _x;
				_vec != _x && driver _vec == _x
			};
			private _civsOnFoot = _civs select {
				vehicle _x == _x
			};

			[_this select 0, _civsOnFoot, "iconMan"] call FUNC(showOnMap_drawCivs);
			[_this select 0, _civsInCarDrivers, "iconCar"] call FUNC(showOnMap_drawCivs);
		}];

		GVAR(unitsOnMapEhs) pushBack [_id, _eventType, _control];
	},
	[_display, _control]
] call CBA_fnc_waitUntilAndExecute;
