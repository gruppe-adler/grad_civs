#define PREFIX GRAD
#define COMPONENT civs

//#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_mission.hpp"

#ifdef DEBUG_MODE_FULL

#define LOGTIME_START(var1)   missionNamespace setVariable [var1,diag_tickTime]
#define LOGTIME_DELTAT(var1)  diag_tickTime - (missionNamespace getVariable [var1,diag_tickTime])
#define LOGTIME_END(var1)     LOG_SYS('PERFORMANCE',format [ARR_3('%1 took %2s',var1,LOGTIME_DELTAT(var1))]); missionNamespace setVariable [var1,nil]
#define ASSERT_SERVER(var1)   if (!assert(!hasInterface || isServer)) exitWith { diag_log(var1); }
#define ASSERT_PLAYER(var1)   if (!assert(hasInterface)) exitWith { diag_log(var1); }

#else

#define LOGTIME_START(var1)
#define LOGTIME_END(var1)
#define ASSERT_SERVER(var1)   if (!(!hasInterface || isServer)) exitWith { diag_log(var1); }
#define ASSERT_PLAYER(var1)   if (!hasInterface) exitWith { diag_log(var1); }

#endif
