#include "..\script_component.hpp"

ISNILS(GVAR(civClasses), []);
if (GVAR(civClasses) isEqualTo []) then {
    private _civClasses = [[QGVAR(civClasses)] call CBA_settings_fnc_get] call FUNC(parseCsv);
    private _civClassDeprecated = [QGVAR(civClass)] call CBA_settings_fnc_get;
    if (_civClassDeprecated != "") then {
        _civClasses pushBackUnique _civClassDeprecated;
    };
    GVAR(civClasses) = _civClasses;
};

GVAR(civClasses)
