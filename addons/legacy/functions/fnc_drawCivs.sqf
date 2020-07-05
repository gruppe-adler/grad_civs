#include "..\script_component.hpp"

params [
    "_map",
    "_units",
    "_icon"
];

{
    _map drawIcon [_icon, [0.4,0,0.5,0.5], getPos _x, 24, 24, getDir _x, ([_x, "business"] call EFUNC(common,civGetState)), 0, 0.03, 'TahomaB', 'right'];
    false
} count _units;
