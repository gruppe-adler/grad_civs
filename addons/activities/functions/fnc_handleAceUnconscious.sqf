#include "..\script_component.hpp"

params [
	["_unit", objNull, [objNull]], 
	["_isUnconscious", true, [true]]
];

private _eventName = if (_isUnconscious) then {QGVAR(unconscious)} else {QGVAR(conscious)};
[_eventName, [_unit], _unit] call CBA_fnc_targetEvent;
