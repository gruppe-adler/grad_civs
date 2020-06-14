#include "..\script_component.hpp"

(vehicle _this == _this) &&
    ([_this, "emotions"] call EFUNC(common,civGetState)) != "emo_panic"
