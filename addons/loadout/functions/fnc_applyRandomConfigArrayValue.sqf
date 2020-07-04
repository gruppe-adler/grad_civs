#include "..\script_component.hpp"

params [
    ["_configVarname", "", [""]],
    ["_args", objNull, [objNull, [], 0, "", false]],
    ["_callback", {}, [{}]]
];

scopeName "main";
private _rawValue = [_configVarname] call cba_settings_fnc_get;
private _arrValue = [];
switch (typeName _rawValue) do {
    case ("STRING"): {
        if (_rawValue == "") then {
            breakOut "main";
        };
        _arrValue = parseSimpleArray _rawValue;
    };
    case ("ARRAY"): {
        _arrValue = _rawValue;
    };
    default {
        ERROR_2("unexpected type %1 for config %2", typeName _rawValue, _configVarname);
        breakOut "main";
    };
};

if (count _arrValue == 0) exitWith {};

[_args, (selectRandom _arrValue)] call _callback
