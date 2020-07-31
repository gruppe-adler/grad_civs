#include "..\script_component.hpp"

params [
    ["_position", [0, 0, 0], [[]], [2,3]]
];

assert(_position isEqualType []);

private _populationZones = [] call FUNC(getPopulationZones);
private _exclusionZones = [] call FUNC(getExclusionZones);

private _inAnyPopulationZone = if (count _populationZones == 0) then {
    true; // "there is no population zone" defaults to "*everywhere* is population zone"
} else {
    _populationZones findIf {_position inArea _x} != -1;
};
if (!_inAnyPopulationZone) exitWith {false};

private _inAnyExclusionZone = _exclusionZones findIf {_position inArea (_x)} != -1;

!_inAnyExclusionZone
