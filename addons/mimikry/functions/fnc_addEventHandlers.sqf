#include "..\script_component.hpp"

["ace_interaction_sendAway", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GO AWAY";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

["ace_interaction_getDown", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GET DOWN";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;


[QEGVAR(interact,pointed_at_inc), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _newCount = (_civ getVariable [QGVAR(pointedAtCount), 0]) + 1;
    _civ setVariable [QGVAR(pointedAtCount), _newCount];

    private _message = format["you're being pointed at with %1 guns", _newCount];
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(interact,pointed_at_dec), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _newCount = (_civ getVariable [QGVAR(pointedAtCount), 0]) - 1;
    if (_newCount < 0) then {
        _newCount = 0;
        WARNING("pointed at underrun!");
    };
    _civ setVariable [QGVAR(pointedAtCount), _newCount];

    private _message = format["you're being pointed at with %1 guns", _newCount];
    if (_newCount == 0) then {
        _message = "you're NOT pointed at with guns anymore";
    };
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(interact,honked_at), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _message = "a car honks at you";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(legacy,doStop), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _message = "someone gestures at you to stop";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(legacy,doReverse), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _message = "someone tells you to reverse";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(legacy,doCarryOn), {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};
    if (side player != civilian) exitWith {};

    private _message = "someone tells you to carry on";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;
