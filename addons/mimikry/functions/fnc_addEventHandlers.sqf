#include "..\script_component.hpp"
#define EXITIFNOTLOCALPLAYERCIV(unit) if (!GVAR(playerActsAsCiv) || {unit != (call CBA_fnc_currentUnit)}) exitWith {}

["ace_interaction_sendAway", {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GO AWAY";
    [_message] call FUNC(showCivHint);

}] call CBA_fnc_addEventHandler;

["ace_interaction_getDown", {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GET DOWN";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(interact,pointed_at_inc), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _newCount = (_civ getVariable [QGVAR(pointedAtCount), 0]) + 1;
    _civ setVariable [QGVAR(pointedAtCount), _newCount];

    private _message = format["you're being pointed at with %1 guns", _newCount];
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(interact,pointed_at_dec), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

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
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _message = "a car honks at you";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(interact,flown_over), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _message = "a helicopter comes dangerously close";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(activities,doStop), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _message = "someone gestures at you to stop";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(activities,doReverse), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _message = "someone tells you to reverse";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;

[QEGVAR(activities,doCarryOn), {
    params ["_civ"];
    EXITIFNOTLOCALPLAYERCIV(_civ);

    private _message = "someone tells you to carry on";
    [_message] call FUNC(showCivHint);
}] call CBA_fnc_addEventHandler;
