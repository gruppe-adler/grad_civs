#include "..\script_component.hpp"

if (leader _this != _this) exitWith {true};

(isNull objectParent _this) &&
    {([_this, "emotions"] call EFUNC(common,civGetState)) != "emo_panic"}
