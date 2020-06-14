#include "..\script_component.hpp"

params [
    ["_plain", ""],
    ["_structured", ""]
];

if (_structured == "") then {
    _structured = _plain;
};

[_structured] call ace_common_fnc_displayTextStructured;
if (GVAR(INFOCHANNEL) == 0) then {
    systemChat _plain;
} else {
    player customChat [GVAR(INFOCHANNEL), _plain];
};
