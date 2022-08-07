#include "..\script_component.hpp"

ISNILS(GVAR(civStateFormat), 0);
ISNILS(GVAR(userActionIds), []);

[FUNC(pfh_drawInfoLines), 0, []] call CBA_fnc_addPerFrameHandler;

if (GVAR(showInfoLine)) then {
    if (!(GVAR(userActionIds) isEqualTo [])) exitWith {};

    private _addCivAction = {
        params [
            ["_title", ""],
            ["_id", 0]
        ];

        player addAction [
            _title,
            { GVAR(civStateFormat) = _this#3; },
            _id,
            10,
            false,
            false,
            "",
            QGVAR(showInfoLine)
        ];
    };

    GVAR(userActionIds) = [
        ["<t color='#3333FF'>civstate format: empty</t>", 0] call _addCivAction,
        ["<t color='#3333FF'>civstate format: infoLine</t>", 1] call _addCivAction,
        ["<t color='#3333FF'>civstate format: speed</t>", 2] call _addCivAction,
        ["<t color='#3333FF'>civstate format: guns</t>", 3] call _addCivAction,
        ["<t color='#3333FF'>civstate format: locality</t>", 4] call _addCivAction,
        ["<t color='#3333FF'>civstate format: behaviour</t>", 5] call _addCivAction,
        ["<t color='#3333FF'>civstate format: state times</t>", 6] call _addCivAction,
        ["<t color='#3333FF'>civstate format: waypoints</t>", 7] call _addCivAction,
        ["<t color='#3333FF'>civstate format: distance</t>", 8] call _addCivAction,
        ["<t color='#3333FF'>civstate format: type</t>", 9] call _addCivAction,
        ["<t color='#3333FF'>civstate format: vehicle move info</t>", 10] call _addCivAction,
        ["<t color='#3333FF'>civstate format: animations</t>", 11] call _addCivAction
    ];
} else {
    {
        player removeAction _x;
    } forEach GVAR(userActionIds);
    GVAR(userActionIds) = [];
};
