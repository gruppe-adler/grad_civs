#include "..\script_component.hpp"

params [
    ["_clickPos", [], [[0, 0, 0]]]
];

[[], _clickPos] call EFUNC(voyage,addCarCrew);
