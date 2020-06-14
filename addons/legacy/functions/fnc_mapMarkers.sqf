#include "..\script_component.hpp"

params [
    ["_onOff", GVAR(debugCivState)]
];

ASSERT_PLAYER("");

GVAR(debugCivState) = _onOff;

if (_onOff) then {
    GVAR(DRAWUNITSEH) = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {

        private _civs = [] call FUNC(getGlobalCivs);
        private _civsInCarDrivers = _civs select {
            private _vec = vehicle _x;
            _vec != _x && driver _vec == _x
        };
        private _civsOnFoot = _civs select {
            vehicle _x == _x
        };

        [_this select 0, _civsOnFoot, "iconMan"] call FUNC(drawCivs);
        [_this select 0, _civsInCarDrivers, "iconCar"] call FUNC(drawCivs);
        //one day: iconHelicopter
    }];
} else {
    ISNILS(GVAR(DRAWUNITSEH), -1);
    ((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", GVAR(DRAWUNITSEH)];
};
