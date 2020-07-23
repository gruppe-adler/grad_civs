#include "..\script_component.hpp"

ISNILS(GVAR(DRAWUNITSEH), -1);
if (GVAR(showOnMap)) then {
	if (GVAR(DRAWUNITSEH) != -1) exitWith {};

    GVAR(DRAWUNITSEH) = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {

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
} else {
	if (GVAR(DRAWUNITSEH) == -1) exitWith {};
    ((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", GVAR(DRAWUNITSEH)];
	GVAR(DRAWUNITSEH) = -1;
};
