#include "..\script_component.hpp"

params [
    "_map",
    "_units",
    "_icon"
];

{
    private _bus = "";
    if (local _x) then {
        _bus = [_x, "business"] call EFUNC(common,civGetState); // works local only :sad:
        if (_bus == "") then {
            private _bus = [_x, "activities"] call EFUNC(common,civGetState);
        };
    };
    _map drawIcon [_icon, [0.4,0,0.5,0.5], getPos _x, 24, 24, getDir _x, _bus, 0, 0.03, 'TahomaB', 'right'];
} forEach _units;
