#include "..\..\component.hpp"

params ["_playerPositions","_mode"];
private ["_cleanupDistance","_civsArray","_civsArrayVar","_idVar"];

switch (_mode) do {
    case ("onfoot"): {
        _cleanupDistance = GRAD_CIVS_SPAWNDISTANCEMAX * 1,2;
        _civsArray = GRAD_CIVS_ONFOOTUNITS;
        _civsArrayVar = "GRAD_CIVS_ONFOOTUNITS";
        _idVar = "GRAD_CIVS_CLEANUPID_ONFOOT";
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
    GRAD_CIVS_ONFOOTCOUNT = GRAD_CIVS_ONFOOTCOUNT - 1;
    if (GRAD_CIVS_DEBUGMODE) then {publicVariable _civsArrayVar; publicVariable "GRAD_CIVS_ONFOOTCOUNT"};

    deleteVehicle _civ;
};
