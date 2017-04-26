#include "..\..\component.hpp"

params ["_civ"];

if (_civ getVariable ["GRAD_civs_stopScriptRunning", false]) exitWith {
    INFO("already one instance of stopciv running");
};

[_civ] spawn {
    params ["_civ"];

    _civ setVariable ["GRAD_civs_stopScriptRunning", true];

    [_civ] call GRAD_CIVS_ONHELDUP;

    _isInCar = (!(_civ isEqualTo vehicle _civ));
    _veh = vehicle _civ;
    _grp = group _civ;


    if (_isInCar) then {
        _civ setVariable ["GRAD_civs_currentlyThinking", "aaaah i need to stop the car"];
        doStop _civ;

        waitUntil {speed vehicle _civ < 1};
        {
            {unassignvehicle _veh} forEach units _grp;

            doGetOut _x;
        } forEach crew _veh;
        waitUntil {vehicle _civ == _civ};
        waitUntil {isTouchingGround _civ};
        sleep 1;
    } else {
        doStop _civ;
    };

    doStop _civ;
    [_civ, true] call ACE_captives_fnc_setSurrendered;
    sleep 1;
    _civ disableAI "MOVE";
    _civ disableAI "ANIM";


    INFO("disabling AI");
    _civ setVariable ["GRAD_civs_currentlyThinking", "cant run away or i will be shot"];

    waitUntil {sleep 3; count (_civ getVariable ["GRAD_civs_isPointedAtBy",[]]) == 0};

    _civ setVariable ["GRAD_civs_currentlyThinking", "he doesnt target me anymore, i can goooo"];
    _civ enableAI "MOVE";
    _civ enableai "ANIM";
    [_civ, false] call ACE_captives_fnc_setSurrendered;

    if (_isInCar && {(canMove _veh)}) then {

            /*
            dofollow again to move on to old waypoints from engima
            leader is safer, as driver could be dead already
            */


            (leader _grp) assignAsDriver _veh;
            {
                if (_x != leader _grp) then {
                    _x assignAsCargo _veh;
                }
            } forEach units _grp;

            units _grp orderGetIn true;
            INFO_1("%1 ordered to get in", leader _grp);
            (leader _grp) setVariable ["GRAD_civs_currentlyThinking", "lets get in"];
           units _grp doFollow leader _grp;

    } else {
units _grp doFollow leader _grp;

        (leader _grp) setVariable ["GRAD_civs_currentlyThinking", "lets patrol around"];
        INFO_1("%1 ordered to patrol", leader _grp);
        [_grp, position (leader _grp), 400 - (random 300), [3,6], [0,2,10]] call GRAD_civs_fnc_taskPatrol;

    };

    _civ setVariable ["GRAD_civs_stopScriptRunning", false];
};
