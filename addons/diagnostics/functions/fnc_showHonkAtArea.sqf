#include "..\script_component.hpp"

ISNILS(GVAR(honkHandler), -1);
if (GVAR(showHonkAtArea)) then {
    if (GVAR(honkHandler) > -1) exitWith {};

    GVAR(honkHandler) = [QEGVAR(legacy,honking_at_poly), {
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
            [CBA_missionTime + 3, _this],
            0
        ] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_addEventHandler;
} else {
    [QEGVAR(legacy,honking_at_poly), GVAR(honkHandler)] call CBA_fnc_removeEventHandler;
    GVAR(honkHandler) = -1;
};
