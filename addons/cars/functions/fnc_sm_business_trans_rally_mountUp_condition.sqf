#include "..\script_component.hpp"

if (leader _this != _this) exitWith {};

private _haveVehicle = (canMove (_this call FUNC(getGroupVehicle)));

if (!_haveVehicle && (_this getVariable ["grad_civs_primaryTask", ""] in ["voyage", "transit"])) exitWith {
    _this setVariable ["grad_civs_primaryTask", "patrol", true];
    INFO_1("%1 was tasked with voyage but vehicle %2 is immovable or absent - will go on patrol hencewith", _this, _this call FUNC(getGroupVehicle));
};
_haveVehicle
