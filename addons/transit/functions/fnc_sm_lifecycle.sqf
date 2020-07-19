#include "..\script_component.hpp"

params [
    ["_lifecycle", locationNull, [locationNull]]
];

private _lifecycle_life = "lfc_life";
private _lifecycle_despawn = "lfc_despawn";

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_despawn,
    { _this call FUNC(sm_lifecycle_trans_life_despawn_condition) },
    {},
    "transit_" + _lifecycle_life + _lifecycle_despawn
] call EFUNC(cba_statemachine,addTransition));
