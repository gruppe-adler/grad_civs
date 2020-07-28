#include "..\script_component.hpp"

(_this getVariable [QGVAR(pointedAtCount), 0] <= 0) &&
((CBA_missionTime - (_this getVariable ["grad_civs_surrenderTime", 0])) > 3)
