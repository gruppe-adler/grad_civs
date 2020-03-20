/* return house or objNull */

#include "..\..\component.hpp"

params [
    ["_position", [0, 0, 0]],
    ["_radius", 0]
];

LOG_2("looking for unclaimed house at %1 within %2 m", _position, _radius);

private _houses = [
    _position,
    _radius
] call grad_civs_fnc_findBuildings;

//exclusion list for houses
private _exclusionList = [
	"Land_Pier_F",
	"Land_Pier_small_F",
	"Land_NavigLight",
	"Land_LampHarbour_F",
	"Land_runway_edgelight",
    "gm_structure_euro_80_wall_base"
];

private _minPosCount = 2;

LOG_3("%1 houses within %2m of %3, will whittle down by positions and excluded types", count _houses, _radius, _position);

private _idx = _houses findIf {
    private _isUnoccupied = (count (_x getVariable ["grad_civs_residents", []])) == 0;
    private _hasEnoughPositions = (count (_x buildingPos -1)) >= _minPosCount;
    private _goodHouseType = !((typeOf _x) in _exclusionList);

    _isUnoccupied && _hasEnoughPositions && _goodHouseType
};

if (_idx != -1) then {
    _houses select _idx
} else {
    objNull
}
