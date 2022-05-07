#include "..\script_component.hpp"

private _pointingCount = _this getVariable [QGVAR(pointedAtCount), 0];
private _recklessness = _this getVariable ["grad_civs_recklessness", 5]; // goes from 0…10 as gaussian distribution

// recklessness gets reduced somewhat by the number of people pointing their weapons
private _pointingPower = switch (_pointingCount) do {
    case 0: { 0 };
    case 1: { 8 };
    case 2: { 12 };
    default { 14 };
};

(_pointingPower - _recklessness) >= 0
