/* return house or objNull */

#include "..\..\component.hpp"

params [
    ["_position", [0, 0, 0]],
    ["_radius", 0]
];

LOG_2("looking for unclaimed house at %1 within %2 m", _position, _radius);

private _houses = [_position, _radius, 2] call grad_civs_fnc_findBuildings;

LOG_1("_houses found initially: %1", _houses);

_houses = _houses select {
    (count (_x getVariable ["grad_civs_residents", []])) == 0
};

LOG_1("_houses found unclaimed: %1", _houses);

if (count _houses > 0) then {
    selectRandom _houses
} else {
    objNull
}
