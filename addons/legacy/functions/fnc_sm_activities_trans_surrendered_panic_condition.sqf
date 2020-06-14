#include "..\script_component.hpp"

(_this call FUNC(sm_activities_helper_freeCondition)) && (([_this, "emotions"] call EFUNC(common,civGetState)) == "emo_panic")
