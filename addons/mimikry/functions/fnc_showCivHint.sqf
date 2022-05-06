#include "..\script_component.hpp"

params [
    ["_plain", ""],
    ["_structured", ""]
];

if (_structured == "") then {
    _structured = _plain;
};

if (!isNil "ace_common_fnc_displayTextStructured") then {
    [_structured] call ace_common_fnc_displayTextStructured;
};
systemChat _plain;
