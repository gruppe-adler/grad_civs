#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    if (hasInterface) then {
        call FUNC(showOnMaps);
        call FUNC(showPointingHints);
        call FUNC(showInfoLine);
        call FUNC(showFps);
    };

    if (isServer || CBA_isHeadlessClient) then {
        GVAR(debugLoopHandle) = [{
            params ["", "_handle"];
            if (hasInterface && (!isGameFocused || isGamePaused)) exitWith {};
            if (call EGVAR(lifecycle,EXITON)) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
            if (GVAR(showInfoLine)) then {
                { _x call FUNC(updateInfoLine); } forEach EGVAR(lifecycle,localCivs);
            };
        }, 1, []] call CBA_fnc_addPerFrameHandler;

        [
            {
                if (GVAR(showFps)) then {
                    [QGVAR(fps), [clientOwner, diag_fps, count EGVAR(lifecycle,localCivs)]] call CBA_fnc_globalEvent;
                };
            },
            2,
            []
        ] call CBA_fnc_addPerFrameHandler;
    };

    if (isServer) then {
        [
            QEGVAR(lifecycle,civ_added),
            {
                {
                    private _civ = _x;
                    _civ setVariable [QGVAR(localAt), owner _civ, true];
                    _civ addEventHandler ["Local", {
                        params ["_civ", ""];
                        _civ setVariable [QGVAR(localAt), owner _civ, true];
                    }];
                } forEach _this;

            }
        ] call CBA_fnc_addEventHandler;
    };
}] call CBA_fnc_addEventHandler;
