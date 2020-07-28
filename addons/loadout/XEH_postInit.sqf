#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

[QEGVAR(common,civ_added), {
    params [["_civ", objNull, [objNull]]];
    assert(!isNull _civ);
    if (local _civ) then {
        [_civ] call FUNC(civAddLoadout);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(broadcastFace), {
    params [
        ["_unit", objNull, [objNull]],
        ["_face", "", [""]]
    ];
    if (isNull _unit) exitWith {};
    _unit setFace _face;
}] call CBA_fnc_addEventHandler;
