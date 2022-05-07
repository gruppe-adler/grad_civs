#include "..\script_component.hpp"

params [
	["_civ", objNull, [objNull]]
];

[_civ] call FUNC(arrowDelete);
[_civ] call FUNC(arrowAdd);
