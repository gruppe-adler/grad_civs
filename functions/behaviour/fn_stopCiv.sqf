#include "..\..\component.hpp"

params ["_civ"];

private _grp = group _civ;

if (_grp getVariable ["GRAD_civs_stopScriptRunning", false]) exitWith {
    INFO("already one instance of stopciv running");
};

_grp setVariable ["GRAD_civs_stopScriptRunning", true];

[_civ] call GRAD_CIVS_ONHELDUP;

_grp setVariable ["grad_civs_ownedVehicle",if (_civ isEqualTo vehicle _civ) then {objNull} else {vehicle _civ}];
_grp leaveVehicle vehicle _civ;
doStop units _grp;


private _onVehicleExit = {
    params ["_civ","_grp","_onUntargeted"];

    {
        [_x, true] call ACE_captives_fnc_setSurrendered;
        _x disableAI "MOVE";
        _x disableAI "ANIM";
        _x setVariable ["GRAD_civs_currentlyThinking", "cant run away or i will be shot"];
        false
    } count units _grp;

    [{{count (_x getVariable ["GRAD_civs_isPointedAtBy",[]]) > 0} count units (_this select 1) == 0},_onUntargeted,[_civ,_grp]] call CBA_fnc_waitUntilAndExecute;
};

private _onUntargeted = {
    params ["_civ","_grp"];

    {
        _x setVariable ["GRAD_civs_currentlyThinking", "he doesnt target me anymore, i can goooo"];
        _x enableAI "MOVE";
        _x enableai "ANIM";
        [_x, false] call ACE_captives_fnc_setSurrendered;
        false
    } count units _grp;

    units _grp doFollow leader _grp;

    //canMove objNull is false, so nullcheck not needed here
    _veh = _grp getVariable ["grad_civs_ownedVehicle",objNull];
    if (canMove _veh) then {
        (leader _grp) assignAsDriver _veh;
        {
            if (_x != leader _grp) then {_x assignAsCargo _veh};
            false
        } count units _grp;
        units _grp orderGetIn true;
    } else {
        (leader _grp) setVariable ["GRAD_civs_currentlyThinking", "lets patrol around"];
        [_grp, position (leader _grp), 400 - (random 300), [3,6], [0,2,10]] call GRAD_civs_fnc_taskPatrol;
        _grp setVariable ["GRAD_civs_stopScriptRunning", false];
    };
};

[{{!(_x isEqualTo vehicle _x)} count units (_this select 1) == 0},_onVehicleExit,[_civ,_grp,_onUntargeted],60,{}] call CBA_fnc_waitUntilAndExecute;
