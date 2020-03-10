#include "..\..\component.hpp"

_this enableDynamicSimulation false; // prevent from freezing mid-flight (?)
[QGVAR(switchMove), [_this, ""]] call CBA_fnc_globalEvent; // leave everything
_this forceSpeed -1;
