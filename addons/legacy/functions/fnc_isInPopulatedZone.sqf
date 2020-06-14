#include "..\script_component.hpp"

params [
    ["_position", [0, 0, 0]]
];

assert(_position isEqualType []);

private _populationZones = [] call FUNC(getPopulationZones);
private _exclusionZones = [] call FUNC(getExclusionZones);

private _inAnyPopulationZone = if (count _populationZones == 0) then {
    true
} else {
    // TODO uhm… how about [] findIf {} != -1 ?
    [_populationZones, {_position inArea (_this#0)}] call FUNC(arrayContains)
};
if (!_inAnyPopulationZone) exitWith {false};

private _inAnyExclusionZone = [_exclusionZones, {_position inArea (_this#0)}] call FUNC(arrayContains);

!_inAnyExclusionZone
