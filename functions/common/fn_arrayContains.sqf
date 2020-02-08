params [
    ["_arr", []],
    ["_discriminator", {}]
];

if ((count _arr) == 0) exitWith {false};

{
    private _result = [_x, _forEachIndex] call _discriminator;
    if (_result) exitWith {true}; false
} forEach _arr
