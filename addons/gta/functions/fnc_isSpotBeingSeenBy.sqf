#include "..\script_component.hpp"

params [
	["_position", [0, 0, 0], [[]]],
	["_visibility", 0.5, [0]],
	["_subjects", [], [[]]]
];

-1 != _subjects findIf {(([objNull, "VIEW"] checkVisibility [eyePos /*leader???*/_x, _parkingPos]) > 0.5)};
