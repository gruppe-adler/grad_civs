#include "..\script_component.hpp"

/* get ALL managed civ vehicles, regardless of location*/
params [
    ["_primaryTask", "", [""]] /* filter civs by primary task */
];

private _civs = _this call EFUNC(lifecycle,getGlobalCivs);
private _vehicles = [];
{
    private _veh = vehicle _x;
    if (_veh != _x) then {
        _vehicles pushBackUnique _veh;
    };
} forEach _civs;

_vehicles
