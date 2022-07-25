#include "script_component.hpp"

["CBA_SettingsInitialized", {
    if (!(EGVAR(main,enabled))) exitWith {};

    [QEGVAR(lifecycle,civ_added), {    
        {
            private _civ = _x;
            if (local _civ) then {
                [_civ] call FUNC(civAddLoadout);
            };
        } forEach _this;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(broadcastFace), {
        params [
            ["_unit", objNull, [objNull]],
            ["_face", "", [""]]
        ];
        if (isNull _unit) exitWith {};
        _unit setFace _face;
    }] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;
