#include "..\script_component.hpp"

[QEGVAR(interact,flyscare_poly), GVAR(flyscareHandler)] call CBA_fnc_removeEventHandler;
GVAR(flyscareHandler) = -1;

ISNILS(GVAR(dangerPolyGroundHelpers), []);
[] call FUNC(showFlyScarePoly_cleanupGroundHelpers);

if (!GVAR(showMisc)) exitWith {};

GVAR(flyscareHandler) = [QEGVAR(interact,flyscare_poly), {
    [
        {
            if (!isGameFocused || isGamePaused) exitWith {};
            params [
                ["_args", [], [[]]],
                ["_handle", 0, [0]]
            ];
            _args params [
                ["_endTime", 0, [0]],
                ["_poly", [], [[]]],
                ["_polyGround", [], [[]]]
            ];
            if (CBA_missionTime >= _endTime) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            [_poly, _polyGround] call FUNC(drawFlyScarePoly);
        },
        0,
        [CBA_missionTime + 0.5, _this#0]
    ] call CBA_fnc_addPerFrameHandler;

    [] call FUNC(showFlyScarePoly_cleanupGroundHelpers);
    {
        [_x] call FUNC(showFlyScarePoly_addGroundHelper);
    } forEach (_this#1);
}] call CBA_fnc_addEventHandler;
