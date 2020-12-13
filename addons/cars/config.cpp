#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"grad_civs_common", "grad_civs_activities"};
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
