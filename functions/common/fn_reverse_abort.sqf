#include "..\..\component.hpp"

params [
    ["_vehicle", objNull]
];

_vehicle setVariable [QGVAR(abortReverse), true, true];
