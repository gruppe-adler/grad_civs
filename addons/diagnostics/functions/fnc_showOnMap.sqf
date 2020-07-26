#include "..\script_component.hpp"

[
	{!isNull (findDisplay 12)},
	{
		GVAR(DRAWUNITSEH) = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
			if (!GVAR(showOnMap)) exitWith {};

		    private _civs = [] call EFUNC(legacy,getGlobalCivs);
		    private _civsInCarDrivers = _civs select {
		        private _vec = vehicle _x;
		        _vec != _x && driver _vec == _x
		    };
		    private _civsOnFoot = _civs select {
		        vehicle _x == _x
		    };

		    [_this select 0, _civsOnFoot, "iconMan"] call FUNC(showOnMap_drawCivs);
		    [_this select 0, _civsInCarDrivers, "iconCar"] call FUNC(showOnMap_drawCivs);
		    //one day: iconHelicopter
		}];
	},
	[]
] call CBA_fnc_waitUntilAndExecute;
