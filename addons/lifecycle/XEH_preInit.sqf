#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

GVAR(excludedFinalClasses) = [
	"Land_Pier_F",
	"Land_Pier_small_F",
	"Land_NavigLight",
	"Land_LampHarbour_F",
	"Land_runway_edgelight",
    "gm_structure_euro_80_wall_base",
    "Land_MilOffices_V1_F",
    "Land_Radar_F",
	"Land_dp_bigTank_F",
	"Land_dp_bigTank_old_F"
];

GVAR(excludedParentClasses) = [
    "CargoPlatform_01_base_F",
    "Cargo_Tower_base_F",
    "Cargo_HQ_base_F",
    "Cargo_House_base_F",
    "Cargo_Patrol_base_F",
    "Land_i_Barracks_V1_F" // yes, is parent for others!
];

[] call FUNC(initConfig);

