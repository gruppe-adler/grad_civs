#include "\x\cba\addons\main\script_macros_common.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#ifdef DEBUG_MODE_FULL

#define ASSERT_SERVER(var1)   if (!assert(CBA_isHeadlessClient || isServer)) exitWith { diag_log(var1); }
#define ASSERT_PLAYER(var1)   if (!assert(hasInterface)) exitWith { diag_log(var1); }

#else

#define ASSERT_SERVER(var1)   if (!(CBA_isHeadlessClient || isServer)) exitWith { diag_log(var1); }
#define ASSERT_PLAYER(var1)   if (!hasInterface) exitWith { diag_log(var1); }

#endif

#define ALL_HUMAN_PLAYERS (allPlayers - (entities "HeadlessClient_F"))
// alternatively, does exclude zeus iirc: #define ALL_HUMAN_PLAYERS ([] call CBA_fnc_players)
