#include "..\script_component.hpp"

(([_this, "emotions"] call EFUNC(common,civGetState)) == "emo_panic") || (_this call EFUNC(interact,sm_activities_helper_surrenderCondition))
