#include "..\script_component.hpp"

[
    QEGVAR(movement,path_calculated),
    {
        params [
            ["_group", grpNull, [grpNull]],
            ["_pathId", -1, [0]],
            ["_path", [], [[]]]
        ];
        [_path, "colorCivilian"] call FUNC(paintPath);
    }
] call CBA_fnc_addEventHandler;

[
    FUNC(paintPathCleanup),
    [],
    5
] call CBA_fnc_addPerFrameHandler;
