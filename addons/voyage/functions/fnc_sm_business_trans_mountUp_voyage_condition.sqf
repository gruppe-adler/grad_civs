#include "..\script_component.hpp"

private _civ = _this;

if (leader _civ != _this) exitWith {false};

private _groupVehicle = _civ call EFUNC(cars,getGroupVehicle);
private _units = units _civ;

private _allAssigned = {
    (_units arrayIntersect (crew _groupVehicle)) isEqualTo _units
};

private _allMounted = {
    private _mountedUnits = _units select {vehicle _x == _groupVehicle};
    (_units arrayIntersect _mountedUnits) isEqualTo _units
};

private _isTaskTransit = _civ getVariable ["grad_civs_primaryTask", ""] == "voyage";

_isTaskTransit && _allAssigned && _allMounted
