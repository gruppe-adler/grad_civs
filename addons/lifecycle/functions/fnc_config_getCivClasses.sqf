#include "..\script_component.hpp"

if (GVAR(civClasses) isEqualType "") then {
    GVAR(civClasses) = [GVAR(civClasses)] call FUNC(parseCsv);
};

GVAR(civClasses)
