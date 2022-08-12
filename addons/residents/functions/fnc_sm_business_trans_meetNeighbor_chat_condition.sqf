#include "..\script_component.hpp"

private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {
    LOG_1("%1 : cannot enter conversation because neighbor ceased to exist", _this);
    false
};
if (!(alive _neighbor)) exitWith {
    LOG_2("%1 : cannot enter conversation because %2 is dead", _this, _neighbor);
    false
};

/*get closer than 2m to have a conversation*/
if ((_this distance _neighbor) < 2) exitWith {
    LOG_2("%1 : entering conversation after being closer than 2m from %2", _this, _neighbor);
    true
};

false
