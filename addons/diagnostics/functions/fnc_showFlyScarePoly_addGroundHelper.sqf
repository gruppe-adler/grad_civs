#include "..\script_component.hpp"

params [
    ["_position", [0, 0, 0], [[]]]
];

GVAR(dangerPolyGroundHelpers) pushBackUnique (createSimpleObject ["Sign_Sphere100cm_F", _position, true]);
