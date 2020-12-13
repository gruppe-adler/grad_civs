#include "..\script_component.hpp"

if (leader _this != _this) exitWith {true};

if (driver vehicle _this != _this) exitWith {true};

if (!(canMove vehicle _this)) exitWith {true};

(([_this, "emotions"] call EFUNC(common,civGetState)) == "emo_panic") || (_this call EFUNC(interact,sm_activities_helper_surrenderCondition))
