

GRAD_civs_mainLoop = [{
    params ["_args", "_handle"];

    if (MISSION_COMPLETED) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

    _playerPositions = call GRAD_civs_fnc_getPlayerPositions;

    if (GRAD_CIV_ONFOOT_COUNT < GRAD_CIV_MAX_COUNT) then {
    	[_playerPositions] call GRAD_civs_fnc_addNewCivilian;
    };


},10,[]] call CBA_fnc_addPerFrameHandler;