#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "CBA_Extended_EventHandlers"
            #ifdef WITH_ACE3_DEPENDENCY
                , "ace_common"
            #endif
            , "grad_civs_activities"
        };
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
