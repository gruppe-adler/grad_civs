#include "..\script_component.hpp"

GVAR(flyscareHandler) = [QEGVAR(interact,flyscare_poly), {
    if (!GVAR(showMisc)) exitWith {};
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

    ISNILS(GVAR(dangerPolyGroundHelpers), []);
    { deleteVehicle _x } foreach GVAR(dangerPolyGroundHelpers);
    GVAR(dangerPolyGroundHelpers) = [];
    {
        GVAR(dangerPolyGroundHelpers) pushBackUnique (createSimpleObject ["Sign_Sphere100cm_F", _x, true]);
        private _y = [_x#0, _x#1, (_x#2) + 1];
        GVAR(dangerPolyGroundHelpers) pushBackUnique (createSimpleObject ["Sign_Pointer_F", _y, true]);
    } forEach (_this#1);
}] call CBA_fnc_addEventHandler;
