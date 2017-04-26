GRAD_civ_clothes_MUD = [
	"LOP_U_AM_Fatigue_01",
    "LOP_U_AM_Fatigue_01_2",
    "LOP_U_AM_Fatigue_01_3",
    "LOP_U_AM_Fatigue_01_4",
    "LOP_U_AM_Fatigue_01_5",
    "LOP_U_AM_Fatigue_01_6",
    "LOP_U_AM_Fatigue_02",
    "LOP_U_AM_Fatigue_02_2",
    "LOP_U_AM_Fatigue_02_3",
    "LOP_U_AM_Fatigue_02_4",
    "LOP_U_AM_Fatigue_02_5",
    "LOP_U_AM_Fatigue_02_6",
    "LOP_U_AM_Fatigue_03",
    "LOP_U_AM_Fatigue_03_2",
    "LOP_U_AM_Fatigue_03_3",
    "LOP_U_AM_Fatigue_03_4",
    "LOP_U_AM_Fatigue_03_5",
    "LOP_U_AM_Fatigue_03_6",
    "LOP_U_AM_Fatigue_04",
    "LOP_U_AM_Fatigue_04_2",
    "LOP_U_AM_Fatigue_04_3",
    "LOP_U_AM_Fatigue_04_4",
    "LOP_U_AM_Fatigue_04_5",
    "LOP_U_AM_Fatigue_04_6"
];

GRAD_civ_clothes_EUR = [
	"rds_uniform_Worker1",
	"rds_uniform_Worker2",
	"rds_uniform_Worker3",
	"rds_uniform_Worker4",
	"rds_uniform_Woodlander1",
	"rds_uniform_Woodlander2",
	"rds_uniform_Woodlander3",
	"rds_uniform_Woodlander4",
	"rds_uniform_Villager1",
	"rds_uniform_Villager2",
	"rds_uniform_Villager3",
	"rds_uniform_Villager4",
	"rds_uniform_Profiteer1",
	"rds_uniform_Profiteer2",
	"rds_uniform_Profiteer3",
	"rds_uniform_Profiteer4",
	"rds_uniform_citizen1",
	"rds_uniform_citizen2",
	"rds_uniform_citizen3",
	"rds_uniform_citizen4"
];

GRAD_civ_headgear_EUR = [
	"rds_Villager_cap1",
	"rds_Villager_cap2",
	"rds_Villager_cap3",
	"rds_Villager_cap4",
	"rds_worker_cap1",
	"rds_worker_cap2",
	"rds_worker_cap3",
	"rds_worker_cap4",
	"rds_Profiteer_cap1",
	"rds_Profiteer_cap2",
	"rds_Profiteer_cap3",
	"rds_Profiteer_cap4",
	"rhs_beanie_green",
	"rhs_beanie_green"
];

GRAD_civ_headgear_MUD = [
	"LOP_H_Turban",
    "LOP_H_Turban",
    "LOP_H_Pakol",
    "LOP_H_Pakol",
    "LOP_H_Pakol",
    "LOP_H_Pakol"
];

GRAD_civ_faces = [
	"PersianHead_A3_01",
	"PersianHead_A3_02",
	"PersianHead_A3_03",
	"PersianHead_A3_01",
	"PersianHead_A3_02",
	"PersianHead_A3_03",
	"PersianHead_A3_01",
	"PersianHead_A3_02",
	"PersianHead_A3_03",
	"WhiteHead_08",
	"WhiteHead_16",
	"GreekHead_A3_01",
	"GreekHead_A3_02",
	"GreekHead_A3_03",
	"GreekHead_A3_04"
];

GRAD_civ_beards = [
	"TRYK_Beard_BK",
   	"TRYK_Beard_BK2",
    "TRYK_Beard_BK3",
    "TRYK_Beard_BK4",
    "TRYK_Beard_BW",
    "TRYK_Beard_BK",
    "TRYK_Beard_BK",
    "TRYK_Beard_BK"
];

// check if woodland param is already set by mission, otherwise spawn euro civs
_IS_WOODLAND = missionNamespace getVariable ["IS_WOODLAND",true];

if (_IS_WOODLAND) then {
	GRAD_civ_headgear = GRAD_civ_headgear_EUR;
	GRAD_civ_clothes = GRAD_civ_clothes_EUR;
} else {
	GRAD_civ_headgear = GRAD_civ_headgear_MUD;
	GRAD_civ_clothes = GRAD_civ_clothes_MUD;
};