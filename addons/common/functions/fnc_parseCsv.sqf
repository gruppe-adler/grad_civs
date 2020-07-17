#include "..\script_component.hpp"

/*
    parse list of strings
*/
params [
    ["_rawValue", "", [""]]
];

private _delimiter = ",";

private _firstChar = _rawValue select [0, 1];
if (_firstChar == "") exitWith {[]};

private _firstCharCode = (toArray _firstChar)#0;

switch (_firstChar) do {
    case ("["): { // assume stringified array
        parseSimpleArray _rawValue
    };
    case (""""): { // assume quoted list. add brackets and parse as array.
        parseSimpleArray (format ["[%1]",_rawValue])
    };
    default {
        if (_firstCharCode >= 48 && _firstCharCode <= 57) then { // assume numbers. add brackets and parse as array.
                parseSimpleArray (format ["[%1]",_rawValue])
        } else {
            (_rawValue splitString _delimiter) apply {
                [_x] call CBA_fnc_trim
            }
        };
    };
};
