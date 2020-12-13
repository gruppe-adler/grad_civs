#include "..\script_component.hpp"

private _emo = [_this, "emotions"] call EFUNC(common,civGetState);
private _speed = switch (_emo) do {
    case "emo_panic": {_this getVariable ["grad_civs_runspeed", 6]};
    case "emo_wary": {(_this getVariable ["grad_civs_runspeed", 6]) * 0.66};
    case "emo_relaxed": {_this getSpeed "SLOW"};
    default {_this getSpeed "SLOW"};
};
_this forceSpeed _speed;
