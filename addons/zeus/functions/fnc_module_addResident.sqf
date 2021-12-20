#include "..\script_component.hpp"

params [
    ["_clickPos", [0, 0, 0], [[]]]
];

[[], [_clickPos#0, _clickPos#1, 0]] call EFUNC(residents,addResident);
