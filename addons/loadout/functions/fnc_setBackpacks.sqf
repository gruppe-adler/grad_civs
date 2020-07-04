#include "..\script_component.hpp"

params [["_value",[]],["_probability",0.5]];

[QGVAR(backpacks), str _value, 1, "mission"] call CBA_settings_fnc_set;
[QGVAR(backpackProbability), _probability, 1, "mission"] call CBA_settings_fnc_set;
