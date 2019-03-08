params [
    ["_plain", ""],
    ["_structured", ""]
];

if (_structured == "") then {
    _structured = _plain;
};

[_structured] call ace_common_fnc_displayTextStructured;
if (GRAD_CIVS_INFOCHANNEL == 0) then {
    systemChat _plain;
} else {
    player customChat [GRAD_CIVS_INFOCHANNEL, _plain] ;
};
