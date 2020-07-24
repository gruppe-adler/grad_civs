#include "..\script_component.hpp"

private _veh = vehicle _target;

alive _target &&
    (_veh != _target) &&
    (driver _veh == _target)
