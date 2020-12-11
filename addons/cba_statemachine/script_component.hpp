#define COMPONENT cba_statemachine
#include "\z\grad_civs\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif
#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "\z\grad_civs\addons\main\script_macros.hpp"

#define COMPOUNDONSTATEENTERED(var) (var + "_onCompoundStateEntered")
#define COMPOUNDONSTATELEAVING(var) (var + "_onCompoundStateLeaving")
#define NESTED(var) (var + "_nested")
// see https://github.com/CBATeam/CBA_A3/blob/f62038fadd4fdc0690beb29271bd4cdf8eb57301/addons/statemachine/script_component.hpp#L21
#define ONSTATELEAVING(var) (var + "_onStateLeaving")
#define STATEMACHINEIDVAR(var) (var getVariable "CBA_statemachine_ID")
#define TIMEDONSTATE(var) (var + "_onTimedState")
#define TIMEDONSTATEENTERED(var) (var + "_onTimedStateEntered")
#define TIMEDONSTATELEAVING(var) (var + "_onTimedStateLeaving")
#define TIMEDTRANSITIONCONDITION(var) (var + "_onTimedTransitionCondition")
#define TIMEDTRANSITIONHANDLER(var) (var + "_onTimedTransitionHandler")
#define TIMEVAR(var) format["grad_civs_state_time_%1", var]