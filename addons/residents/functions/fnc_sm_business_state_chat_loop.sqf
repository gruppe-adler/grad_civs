#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {true}; // go to chat only so that chat can lead  to housework in the next tick
if (!(alive _neighbor)) exitWith {true};

/*get closer than 2m to have a conversation*/
/* note: this must be fulfilled to even enter the chat state BUT that neighbor may be on the move somewhere else, so follow them if necessary*/
if ((_this distance _neighbor) < 2) then {
    doStop _this;
    _this lookAt (_this getVariable ["grad_civs_neighborToMeet", objNull]);
} else {
    _this moveTo (getPos _neighbor);
};


_this setRandomLip (selectRandom [false, false, false, true]);
