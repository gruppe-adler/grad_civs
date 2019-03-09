#include "..\..\component.hpp"

params [
    "_map",
    "_units",
    "_icon"
];

{
    _map drawIcon [_icon, [1,1,0,1], getPos _x,24,24, getDir _x, "grad civ", 0, 0.03, 'TahomaB', 'right'];
    false
} count _units;
