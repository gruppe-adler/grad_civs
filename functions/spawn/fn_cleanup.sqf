#include "..\..\component.hpp"

params ["_playerPositions","_mode"];
private ["_cleanupDistance","_civsArray","_civsArrayVar","_counterVar","_idVar"];

switch (_mode) do {
    case ("onfoot"): {
        _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEONFOOTMAX * 1.2;
        _civsArray = GRAD_CIVS_ONFOOTUNITS;
        _civsArrayVar = "GRAD_CIVS_ONFOOTUNITS";
        _counterVar = "GRAD_CIVS_ONFOOTCOUNT";
        _idVar = "GRAD_CIVS_CLEANUPID_ONFOOT";
    };
    case ("invehicles"): {
        _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEINVEHICLESMAX * 1.5;
        _civsArray = GRAD_CIVS_INVEHICLESUNITS;
        _civsArrayVar = "GRAD_CIVS_INVEHICLESUNITS";
        _counterVar = "GRAD_CIVS_INVEHICLESCOUNT";
        _idVar = "GRAD_CIVS_CLEANUPID_INVEHICLES";
    };
};

if (count _civsArray == 0) exitWith {};

private _id = missionNamespace getVariable [_idVar,0];
_id = if (_id >= (count _civsArray)-1) then {0} else {_id+1};
missionNamespace setVariable [_idVar,_id];

private _civ = _civsArray select _id;
private _delete = ({_civ distance _x < _cleanupDistance} count _playerPositions) == 0;

if (_delete) then {
    _civsArray deleteAt _id;
    missionNamespace setVariable [_counterVar,(missionNamespace getVariable [_counterVar,0])-1];
    if (GRAD_CIVS_DEBUGMODE) then {publicVariable _civsArrayVar; publicVariable _counterVar};

    if (vehicle _civ != _civ) then {deleteVehicle vehicle _civ} else {deleteVehicle _civ};
};
