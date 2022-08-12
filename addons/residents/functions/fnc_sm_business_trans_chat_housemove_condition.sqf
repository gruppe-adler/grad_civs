#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {
    LOG_1("%1 : my current chat partner has ceased existing", _this);
    true
};
if (isNull (_neighbor getVariable ["grad_civs_neighborToMeet", objNull])) exitWith {
    LOG_2("%1 : current chat partner %2 does not want to chat anymore", _this, _neighbor);
    true
};

(_this getVariable [QGVAR(chatDuration), 0]) + _thisStateTime < CBA_missionTime
