#include "..\script_component.hpp"

params [["_value",[]]];

[QGVAR(vehicles), _value, 0, "mission"] call CBA_settings_fnc_set;
