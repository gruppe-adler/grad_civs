#include "..\..\component.hpp"

grad_civs_mainLoop = [{
    params ["_args", "_handle"];

    if (call GRAD_CIVS_EXITON) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

    _playerPositions = [] call grad_civs_fnc_getPlayerPositions;

    if (GRAD_CIVS_ONFOOTCOUNT < GRAD_CIVS_MAXCOUNT) then {
    	[_playerPositions] call grad_civs_fnc_addNewCivilian;
    };
    [_playerPositions,"onfoot"] call grad_civs_fnc_cleanup;

},10,[]] call CBA_fnc_addPerFrameHandler;
