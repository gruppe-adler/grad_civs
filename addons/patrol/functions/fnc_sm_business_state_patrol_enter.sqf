#include "..\script_component.hpp"

if (_this == leader _this) then {
    private _grp = group _this;
    (units _grp) doFollow (leader _this);
    [_this, _this, 400 - (random 300), [3,6], [0,2,10]] call FUNC(taskPatrol);

    { // TODO why am I doing this, and if yes, why only here and not when entering other states?
        _x setSpeedMode "LIMITED";
        _x forceSpeed -1;
        _x stop false; // should not be necessary
        _x playMoveNow "AmovPercMstpSnonWnonDnon";
        _x enableDynamicSimulation true;
        false
    } count (units _grp);
    _this call EFUNC(activities,forceEmotionSpeed);
};
