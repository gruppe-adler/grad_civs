["ace_interaction_sendAway", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GO AWAY";
    [_message] call grad_civs_fnc_showCivHint;
}] call CBA_fnc_addEventHandler;

["ace_interaction_getDown", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};

    addCamShake [4, 0.5, 5];

    private _message = "you are being told to GET DOWN";
    [_message] call grad_civs_fnc_showCivHint;
}] call CBA_fnc_addEventHandler;


["pointed_at_inc", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};

    private _newCount = (_civ getVariable ["grad_civs_isPointedAtCount", 0]) + 1;
    _civ setVariable ["grad_civs_isPointedAtCount", _newCount];

    private _message = format["you're being pointed at with %1 guns", _newCount];
    [_message] call grad_civs_fnc_showCivHint;
}] call CBA_fnc_addEventHandler;

["pointed_at_dec", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};

    private _newCount = (_civ getVariable ["grad_civs_isPointedAtCount", 0]) - 1;
    assert(_newCount >= 0);
    if (_newCount < 0) then {_newCount = 0;};
    _civ setVariable ["grad_civs_isPointedAtCount", _newCount];

    private _message = format["you're being pointed at with %1 guns", _newCount];
    if (_newCount == 0) then {
        _message = "you're NOT pointed at with guns anymore";
    };
    [_message] call grad_civs_fnc_showCivHint;
}] call CBA_fnc_addEventHandler;


["honked_at", {
    params ["_civ"];
    if (_civ != ACE_player) exitWith {};

    private _message = "a car honks at you";
    [_message] call grad_civs_fnc_showCivHint;
}] call CBA_fnc_addEventHandler;
