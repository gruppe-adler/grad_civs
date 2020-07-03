#include "..\script_component.hpp"

private _target = (group _this) getVariable [QGVAR(destination), [0, 0, 0]];

(getPos _this) distance2D _target < 15
