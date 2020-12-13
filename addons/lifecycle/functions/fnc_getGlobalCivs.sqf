#include "..\script_component.hpp"

/* get ALL grad managed civs, regardless of location*/
params [
    ["_primaryTask", "", [""]] /* filter civs by primary task */
];

if (isNil QGVAR(getGlobalCivs_arr)) then {
    // on first run, init array with existing civs
    private _civClasses = call FUNC(config_getCivClasses);
    private _potentialCivs = entities [_civClasses, [], true, true];
    GVAR(getGlobalCivs_arr) = _potentialCivs select { (_x getVariable ["grad_civs_primaryTask", ""]) != ""};

    // then, register event handler to update the array appropriately to always include all living civs
    [
        QGVAR(civ_added),
        {
            params [["_civ", objNull, [objNull]]];
            SCRIPT("getGlobalCivs_civ_added");
            GVAR(getGlobalCivs_arr) = GVAR(getGlobalCivs_arr) + [_civ];
        }
    ] call CBA_fnc_addEventHandler;
    [
        QGVAR(civ_removed),
        {
            params [["_civ", objNull, [objNull]]];
            SCRIPT("getGlobalCivs_civ_removed");
            GVAR(getGlobalCivs_arr) = GVAR(getGlobalCivs_arr) - [_civ];
        }
    ] call CBA_fnc_addEventHandler;
};

if (_primaryTask == "") then {
    GVAR(getGlobalCivs_arr)
} else {
    (GVAR(getGlobalCivs_arr) select { _x getVariable ["grad_civs_primaryTask", ""] == _primaryTask})
};
