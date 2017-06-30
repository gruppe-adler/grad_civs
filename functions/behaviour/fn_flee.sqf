#include "..\..\component.hpp"

params ["_unit"];

private _grp = group _unit;
if (_grp getVariable ["GRAD_fleeing",false]) exitWith {};
_grp setVariable ["GRAD_fleeing", true];

{
    _x enableDynamicSimulation false;
} count units _grp;


if !(_unit isEqualTo vehicle _unit) then {
    [{
        _this setVariable ["grad_civs_ownedVehicle",vehicle leader _this];
        _this leaveVehicle vehicle leader _this;
        doStop units _this;
    }, _grp, random 15] call CBA_fnc_waitAndExecute;
};

private _onVehicleExit = {
    params ["_grp","_resumePatrol","_takeCover"];

    private _pos = [0,0,0];

    //run away
    if (50 > random 100) then {
        _pos = [leader _grp,[150,300],[0,360]] call grad_civs_fnc_findRandomPos;
        {
            _x setVariable ["grad_civs_currentlyThinking", "who the fuck is shooting, have to run far away"];
            false
        } count units _grp;

        [{leader (_this select 0) distance (_this select 1) < 10 && {speed leader (_this select 0) < 1}},_resumePatrol,[_grp,_pos],180,{}] call CBA_fnc_waitUntilAndExecute;

    //find cover
    } else {
        _pos = [leader _grp] call grad_civs_fnc_findPositionOfInterest;
        {
            _x setVariable ["grad_civs_currentlyThinking", "who the fuck is shooting, have to find cover"];
            false
        } count units _grp;

        [{leader (_this select 0) distance (_this select 1) < 10 && {speed leader (_this select 0) < 1}},_takeCover,[_grp,_pos,_resumePatrol],180,{}] call CBA_fnc_waitUntilAndExecute;
    };

    //move to pos
    [_grp] call CBA_fnc_clearWaypoints;
    {
        _x doMove _pos;
        _x setSpeedMode "FULL";
        _x forceSpeed 20;
        false
    } count units _grp;
};

private _takeCover = {
    params ["_grp","_pos","_resumePatrol"];
    _animationHiding = ["Acts_CivilHiding_1", "Acts_CivilHiding_2"];

    {
        _x playMoveNow (selectRandom _animationHiding);
        _x stop true;
        _x enableDynamicSimulation true;
        _x setVariable ["grad_civs_currentlyThinking", "taking cover"];
        false
    } count units _grp;

    [{CBA_missionTime - ((_this select 0) getVariable ["grad_civs_lastGunshotHeard",0]) > 240},_resumePatrol,[_grp]] call CBA_fnc_waitUntilAndExecute;
};

private _resumePatrol = {
    params ["_grp"];

    units _grp doFollow leader _grp;
    [_grp, leader _grp, 400 - (random 300), [3,6], [0,2,10]] call grad_civs_fnc_taskPatrol;

    {
        _x setSpeedMode "LIMITED";
        _x forceSpeed -1;
        _x stop false;
        _x playMoveNow "AmovPercMstpSnonWnonDnon";
        _x setVariable ["grad_civs_currentlyThinking", "task patrol assigned"];
        _x enableDynamicSimulation true;
        false
    } count units _grp;

    _grp setVariable ["GRAD_fleeing", false];
};

[{{!(_x isEqualTo vehicle _x)} count units (_this select 0) == 0},_onVehicleExit,[_grp,_resumePatrol,_takeCover],180,{}] call CBA_fnc_waitUntilAndExecute;
