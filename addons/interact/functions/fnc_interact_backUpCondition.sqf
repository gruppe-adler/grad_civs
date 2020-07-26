#include "..\script_component.hpp"

private _veh = vehicle _target; // target may be a vehicle itself
private _driver = driver _veh;

alive _target &&
    (_driver isKindOf "Man") &&
    (_driver getVariable ["grad_civs_primaryTask", ""] != "")
