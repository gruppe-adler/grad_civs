#include "..\script_component.hpp"

params [
	["_value",[], [[]]] // array of vehicle class names
];

assert(_value isEqualTypeAll "");

[QGVAR(vehicles), str _value, 1, "server", true] call CBA_settings_fnc_set;
