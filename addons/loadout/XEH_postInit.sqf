#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};


[QEGVAR(legacy,civ_added), {
    params [["_civ", objNull, [objNull]]];
    assert(!isNull _civ);
    if (local _civ) then {
        [_civ] call FUNC(civAddLoadout);
    };
}] call CBA_fnc_addEventHandler;
