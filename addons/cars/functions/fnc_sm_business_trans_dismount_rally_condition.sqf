#include "..\script_component.hpp"

if (leader _this != _this) exitWith {true};

(vehicle _this == _this) &&
    ([_this, "emotions"] call EFUNC(common,civGetState)) != "emo_panic"
