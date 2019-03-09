#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUG_CIVSTATE]];

ASSERT_PLAYER("");

GRAD_CIVS_DEBUG_CIVSTATE = _onOff;

if (_onOff) then {
    GRAD_CIVS_DRAWUNITSEH = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {

        private _civs = [] call grad_civs_fnc_getGlobalCivs;
        private _civsInCarDrivers = _civs select {
            private _vec = vehicle _x;
            _vec != _x && driver _vec == _x
        };
        private _civsOnFoot = _civs select {
            vehicle _x == _x
        };

        [_this select 0, _civsOnFoot, "iconMan"] call grad_civs_fnc_drawCivs;
        [_this select 0, _civsInCarDrivers, "iconCar"] call grad_civs_fnc_drawCivs;
        //one day: iconHelicopter
    }];
} else {
    ((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw",missionNamespace getVariable ["GRAD_CIVS_DRAWUNITSEH",-1]];
};
