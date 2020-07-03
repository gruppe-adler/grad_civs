#include "..\script_component.hpp"

private _haveVehicle = (canMove (_this call FUNC(getGroupVehicle)));

if (!_haveVehicle && (_this getVariable ["grad_civs_primaryTask", ""] in ["voyage", "transit"])) exitWith {
    _this setVariable ["grad_civs_primaryTask", "patrol", true];
    INFO_1("%1 was tasked with voyage but vehicle %2 is immovable or absent - will go on patrol hencewith", _this, _this call FUNC(getGroupVehicle));
};

private _grpUnits = units _this;
private _allRallying = -1 == (_grpUnits findIf { ([_x, "business"] call EFUNC(common,civGetState)) != "bus_rally" });

_allRallying && _haveVehicle && (leader _this == _this)
