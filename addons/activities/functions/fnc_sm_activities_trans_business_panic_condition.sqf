#include "..\script_component.hpp"

(isNull objectParent _this) &&
    {([_this, "emotions"] call EFUNC(common,civGetState)) == "emo_panic"}
