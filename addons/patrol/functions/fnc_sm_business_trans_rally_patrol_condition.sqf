#include "..\script_component.hpp"

private _grpUnits = units _this;
private _nonRallyCount = {
    ([_this, "business"] call EFUNC(common,civGetState)) != "bus_rally"
} count _grpUnits;
private _allRallying = _nonRallyCount == 0;

_allRallying && ((_this getVariable ["grad_civs_primaryTask", ""]) == "patrol")
