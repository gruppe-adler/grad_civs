#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

[
    QGVAR(do_dismiss_civ),
    {
        params [
            ["_object", objNull, [objNull, grpNull]]
        ];
        if (!((leader _object) in EGVAR(legacy,localCivs))) exitWith {
            INFO_2("not dismissing %1 (%2) as it is not local civ led", _object, typeName _object);
        };

        if (_object isEqualType grpNull) then {
            [_object] call FUNC(dismissGroup);
        } else {
            [_object] call FUNC(dismissCiv);
        };
    }
] call CBA_fnc_addEventHandler;
