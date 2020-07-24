#include "..\script_component.hpp"

ISNILS(GVAR(pointHandler), []);
if (GVAR(showMisc)) then {
    if (GVAR(pointHandler) isEqualTo []) then {
        GVAR(pointHandler) = [
            [
                QEGVAR(interact,pointing),
                {systemChat format["now pointing also at: %1", _this]}
            ] call CBA_fnc_addEventHandler,
            [
                QEGVAR(interact,depointing),
                {systemChat format["now depointing: %1", _this]}
            ] call CBA_fnc_addEventHandler
        ];
    };
} else {
    if (GVAR(pointHandler) isEqualTo []) exitWith {};
    [QEGVAR(interact,pointing), GVAR(pointHandler)#0] call CBA_fnc_removeEventHandler;
    [QEGVAR(interact,depointing), GVAR(pointHandler)#1] call CBA_fnc_removeEventHandler;
};
