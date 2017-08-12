#include "..\..\component.hpp"

params [["_onOff",GRAD_CIVS_DEBUGMODE]];

if (!hasInterface) exitWith {};

GRAD_CIVS_DEBUGMODE = _onOff;

if (_onOff) then {
    GRAD_CIVS_DRAWUNITSEH = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{
        [_this select 0,"GRAD_CIVS_ONFOOTUNITS","iconMan"] call grad_civs_fnc_drawCivs;
        [_this select 0,"GRAD_CIVS_INVEHICLESUNITS","iconCar"] call grad_civs_fnc_drawCivs;
        [_this select 0,"GRAD_CIVS_INAIRCRAFTUNITS","iconHelicopter"] call grad_civs_fnc_drawCivs;
    }];
} else {
    ((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw",missionNamespace getVariable ["GRAD_CIVS_DRAWUNITSEH",-1]];
};
