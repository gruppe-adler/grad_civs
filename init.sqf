if (isServer) then {

	GRAD_civ_clothes = [];
	GRAD_civ_headgear = [];

	// maximum persons on map
	GRAD_CIV_MAX_COUNT = 60;

	GRAD_CIV_MIN_SPAWN_DISTANCE = 1000;
	GRAD_CIV_MAX_SPAWN_DISTANCE = 4500;

	GRAD_CIV_DEBUG = false;

	// do not edit below //
	GRAD_CIV_ONFOOT_COUNT = 0;
	GRAD_CIV_ONFOOT_GROUPS = [];

	call GRAD_civs_fnc_clothDefinitions;
	call GRAD_civs_fnc_serverLoop;

};


if (hasInterface) then {

	call GRAD_civs_fnc_playerLoop;

	if (!isNil "DEBUG_MODE" && {DEBUG_MODE}) then {
		call GRAD_civs_fnc_showWhatTheyThink;
	};

};