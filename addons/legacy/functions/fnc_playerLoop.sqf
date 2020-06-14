#include "..\script_component.hpp"

[{
    if (!isGameFocused || isGamePaused) exitWith {};
    [] call FUNC(checkWeaponOnCivilianPointer);
}, 0.5, []] call CBA_fnc_addPerFrameHandler;

[{
    if (!isGameFocused || isGamePaused) exitWith {};
    if ([] call FUNC(isPlayerHonking)) then {
        [] call FUNC(checkHonkingOnCivilian);
    };
}, 0.1, []] call CBA_fnc_addPerFrameHandler;

[
    "server_fps",
    {
        if ([QGVAR(debugFps)] call CBA_settings_fnc_get) then {
            systemChat format ["%1 fps on %2", _this select 1, _this select 0];
        };
    }
] call CBA_fnc_addEventHandler;
