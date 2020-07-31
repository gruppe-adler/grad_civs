#include "..\script_component.hpp"

[
    QEGVAR(movement,pathCalculated),
    {
        params [
            ["_group", grpNull, [grpNull]],
            ["_pathId", -1, [0]],
            ["_path", [], [[]]]
        ];
        if (GVAR(showPaths) > 0) then {
            [_path, "colorCivilian"] call FUNC(paintPath);
        };
    }
] call CBA_fnc_addEventHandler;

[
    FUNC(paintPathCleanup),
    5,
    []
] call CBA_fnc_addPerFrameHandler;
