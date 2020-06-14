#include "..\script_component.hpp"

// transition if surrendering and has dismounted
(_this call FUNC(sm_activities_helper_surrenderCondition)) && (vehicle _this == _this)
