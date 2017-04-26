params ["_playerPositions"];

[_playerPositions] spawn {
	params ["_playerPositions"];

	_position = [
		_playerPositions, 
		GRAD_CIV_MIN_SPAWN_DISTANCE, 
		GRAD_CIV_MAX_SPAWN_DISTANCE, 
		GRAD_CIV_ONFOOT_GROUPS
	] call GRAD_civs_fnc_findSpawnSegment;

	if (_position isEqualTo [0,0,0]) exitWith {};

	diag_log format ["%1", _position];

	_group = createGroup [civilian, true]; // todo: adapt to 1.67 [civilian, true]
	_unit = _group createUnit ["C_man_1", _position, [], 0, "NONE"];
	

	// _unit disableAI "MOVE";
	_unit disableAI "FSM";
	_unit setBehaviour "CARELESS";

	[_unit] call GRAD_civs_fnc_dressAndBehave;
	_unit enableDynamicSimulation true;

	[_unit, _position, 400 - (random 300), [3,6], [0,2,10]] call GRAD_civs_fnc_taskPatrol;

	if (GRAD_CIV_DEBUG || (!isNil "DEBUG_MODE" && {DEBUG_MODE})) then {
		[_position] call GRAD_civs_fnc_createDebugMarker; 
	};

	GRAD_CIV_ONFOOT_COUNT = GRAD_CIV_ONFOOT_COUNT + 1;
	GRAD_CIV_ONFOOT_GROUPS = GRAD_CIV_ONFOOT_GROUPS + [_unit];

	diag_log format ["added civilian on foot, now %1", GRAD_CIV_ONFOOT_COUNT];

};