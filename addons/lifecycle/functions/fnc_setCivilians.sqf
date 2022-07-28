#include "..\script_component.hpp"

params [
	["_value",[], [[]]] // array of civilian unit class names
];

assert(_value isEqualTypeAll "");

[QGVAR(civClasses), str _value, 1, "mission"] call CBA_settings_fnc_set;
