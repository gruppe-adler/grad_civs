["ace_interaction_sendAway", {
    params ["_unit"];

    if (_unit == ACE_player) then {
        addCamShake [4, 0.5, 5];
        private _message = "you are being told to GO AWAY";
        [_message] call ace_common_fnc_displayTextStructured;
    };
}] call CBA_fnc_addEventHandler;

["ace_interaction_getDown", {
    params ["_unit"];

    if (_unit == ACE_player) then {
        addCamShake [4, 0.5, 5];
        private _message = "you are being told to GET DOWN";
        [_message] call ace_common_fnc_displayTextStructured;
    };
}] call CBA_fnc_addEventHandler;
