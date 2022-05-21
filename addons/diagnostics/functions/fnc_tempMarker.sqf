#include "..\script_component.hpp"

params [
    ["_position", [], [[]]],
    ["_text", "", [""]],
    ["_timeout", 1.5, [0]],
    ["_greenTimeout", 5, [0]]
];

ISNILS(GVAR(markerId), 0);
GVAR(markerId) = GVAR(markerId) + 1;
private _markerName = format ["debugmarker%1", GVAR(markerId)];

private _m = createMarkerLocal [_markerName, _position];
_m setMarkerTextLocal format ["%1_%2", GVAR(markerId), _text];
_m setMarkerTypeLocal "hd_dot";

[
    {
        params ["_m"];
        if ((markerColor _m) isNotEqualTo "ColorGreen") then {
        deleteMarkerLocal _m;
        };
    },
    [_m],
    _timeout
] call CBA_fnc_waitAndExecute;

[
    {
        params ["_m"];
        deleteMarkerLocal _m;
    },
    [_m],
    _greenTimeout
] call CBA_fnc_waitAndExecute;

_m
