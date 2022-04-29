#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "grad_civs_main"
            , "grad_civs_lifecycle"
            #ifdef WITH_ACE3_DEPENDENCY
                , "ace_interaction"
                , "ace_captives"
            #endif
        };
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
