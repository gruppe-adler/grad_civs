(count (_this getVariable ["grad_civs_isPointedAtBy", []]) <= 0) &&
((CBA_missionTime - (_this getVariable ["grad_civs_surrenderTime", 0])) > 3)
