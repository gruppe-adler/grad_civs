#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {
    LOG_1("%1 : I dont remember my chat partner", _this);
};
if (!(alive _neighbor)) exitWith {
    LOG_2("%1 : My chat partner %2 is dead", _this, _neighbor);
};

/*get closer than 2m to have a conversation*/
/* note: this must be fulfilled to even enter the chat state BUT that neighbor may be on the move somewhere else, so follow them if necessary*/
if ((_this distance _neighbor) < 2) then {
    doStop _this;
    _this lookAt (_this getVariable ["grad_civs_neighborToMeet", objNull]);
} else {
    LOG_2("%1 : Will move closer as my chat partner %2 is too far away", _this, _neighbor);
    _this moveTo (getPos _neighbor);
};

_this setRandomLip (selectRandom [false, false, false, true]);
