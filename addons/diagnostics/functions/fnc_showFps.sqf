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
            ["_fps", -1, [0]],
            ["_civCount", 0, [0]]
        ];

        [GVAR(lastFps), _clientId, [_fps, _civCount]] call CBA_fnc_hashSet;
    }
] call CBA_fnc_addEventHandler;

GVAR(fpsPfh) = [
    {
        if (!isGameFocused || isGamePaused) exitWith {};
        if (!GVAR(showFps)) exitWith {};

        private _text = "FPS ";
        [GVAR(lastFps), {
            _text = format ["%1 | %2: %3 (%4)", _text, _key, _value#0, _value#1]
        }] call CBA_fnc_hashEachPair;
        systemChat _text;
    },
    2,
    []
] call CBA_fnc_addPerFrameHandler;
