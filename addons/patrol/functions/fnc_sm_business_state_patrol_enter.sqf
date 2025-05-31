#include "..\script_component.hpp"

private _leader = leader _this;

_this stop false;
_this call EFUNC(activities,forceEmotionSpeed);
_this doFollow _leader;

if (_this == _leader) then {
    private _grp = group _this;
    _grp setSpeedMode "LIMITED";

    [_this, _this, 400 - (random 300), [3,6], [0,2,10]] call FUNC(taskPatrol);
};
