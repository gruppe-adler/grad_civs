#include "..\script_component.hpp"

GVAR(honkHandler) = [QEGVAR(interact,honking_at_poly), {
    if (!GVAR(showMisc)) exitWith {};
    [
        {
            params [
                ["_args", [], [[]]],
                ["_handle", 0, [0]]
            ];
            _args params [
                ["_endTime", 0, [0]],
                ["_poly", [], [[]]]
            ];
            if (CBA_missionTime >= _endTime) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            { // show the honked_at "danger zone" in front of the vehicle
                private _from = _poly select _forEachIndex;
            	private _to = _poly select ((_forEachIndex + 1) mod (count _poly));
            	drawLine3D [_from, _to, [1, 0.3, 0.5, 1]];
            } forEach _poly;
        },
        0,
        [CBA_missionTime + 3, _this]
    ] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
