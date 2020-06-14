#include "..\script_component.hpp"

params [["_value",[]],["_probability",0.5]];

[QGVAR(backpacks), _value, 0, "mission"] call CBA_settings_fnc_set;
[QGVAR(backpackProbability), _probability, 0, "mission"] call CBA_settings_fnc_set;
