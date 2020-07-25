#include "..\script_component.hpp"

ISNILS(GVAR(lastFps), call CBA_fnc_hashCreate);
ISNILS(GVAR(fpsHandler), -1);
ISNILS(GVAR(fpsPfh), -1);

GVAR(fpsHandler) = [
    QGVAR(fps),
    {
        if (!GVAR(showFps)) exitWith {};
        params [
            ["_clientId", -1, [0]],
            ["_fps", -1, [0]]
        ];

        [GVAR(lastFps), _clientId, _fps] call CBA_fnc_hashSet;
    }
] call CBA_fnc_addEventHandler;

GVAR(fpsPfh) = [
    {
        if (!GVAR(showFps)) exitWith {};

        private _text = "FPS ";
        [GVAR(lastFps), {
            _text = format ["%1 | %2: %3", _text, _key, _value]
        }] call CBA_fnc_hashEachPair;
        systemChat _text;
    },
    2,
    []    
] call CBA_fnc_addPerFrameHandler;
