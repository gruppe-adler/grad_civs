#include "..\script_component.hpp"

/* get ALL grad managed civs, regardless of location*/
params [
    ["_primaryTask", "", [""]] /* filter civs by primary task */
];

if (isNil QFUNC(getGlobalCivs_arr)) then {
    // on first run, init array with existing civs
    private _civClasses = call EFUNC(common,config_getCivClasses);
    private _potentialCivs = entities [_civClasses, [], true, true];
    FUNC(getGlobalCivs_arr) = _potentialCivs select { (_x getVariable ["grad_civs_primaryTask", ""]) != ""};

    // then, register event handler to update the array appropriately to always include all living civs
    [
        QGVAR(civ_added),
        {
            SCRIPT("getGlobalCivs_civ_added");
            FUNC(getGlobalCivs_arr) = FUNC(getGlobalCivs_arr) + _this;
        }
    ] call CBA_fnc_addEventHandler;
    [
        QGVAR(civ_removed),
        {
            SCRIPT("getGlobalCivs_civ_removed");
            FUNC(getGlobalCivs_arr) = FUNC(getGlobalCivs_arr) - _this;
        }
    ] call CBA_fnc_addEventHandler;
};

if (_primaryTask == "") then {
    FUNC(getGlobalCivs_arr)
} else {
    (FUNC(getGlobalCivs_arr) select { _x getVariable ["grad_civs_primaryTask", ""] == _primaryTask})
};
