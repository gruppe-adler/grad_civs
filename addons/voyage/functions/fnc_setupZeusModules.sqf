#include "..\script_component.hpp"

["GRAD-CIVS","ADD CAR",
    {
        params [
            ["_clickPos", [0, 0, 0], [[]]]
        ];

        [[], ASLToAGL _clickPos] call FUNC(addCarCrew);
    }
] call zen_custom_modules_fnc_register;
