#include "..\..\component.hpp"

params [
    ["_position", [0, 0, 0]]
];

assert(_position isEqualType []);

private _inAnyPopulationZone = if (count GVAR(POPULATION_ZONES) == 0) then {
    true
} else {
    [GVAR(POPULATION_ZONES), {_position inArea (_this#0)}] call FUNC(arrayContains)
};
if (!_inAnyPopulationZone) exitWith {false};

private _inAnyExclusionZone = [GVAR(EXCLUSION_ZONES), {_position inArea (_this#0)}] call FUNC(arrayContains);

!_inAnyExclusionZone
