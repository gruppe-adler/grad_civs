#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_Extended_EventHandlers", "grad_civs_main", "grad_civs_common", "grad_civs_cba_statemachine"};
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
