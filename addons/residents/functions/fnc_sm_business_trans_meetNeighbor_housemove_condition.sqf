#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {
    LOG_1("%1 : revertin to housemove because neighbor ceased to exist", _this);
    true
};
if (!(alive _neighbor)) exitWith {
    LOG_2("%1 : reverting to housemove because %2 is dead", _this, _neighbor);
    true
};

if ((_thisStateTime + 60) < CBA_missionTime) exitWith {
    LOG_1("%1 : reverting to housemove after trying to meet neighbor for 60s", _this);
    true
};

false
