#include "..\script_component.hpp"

params [
    ["_configVarname", "", [""]],
    ["_args", objNull, [objNull, [], 0, "", false]],
    ["_callback", {}, [{}]]
];

scopeName "main";
private _rawValue = [_configVarname] call cba_settings_fnc_get;
private _arrValue = [_rawValue] call EFUNC(common,parseCsv);

if (count _arrValue == 0) exitWith {};

[_args, (selectRandom _arrValue)] call _callback
