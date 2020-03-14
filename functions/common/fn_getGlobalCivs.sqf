#include "..\..\component.hpp"

/* get ALL grad managed civs, regardless of location*/
params [
    ["_primaryTask", "", ["patrol", "voyage"]] /* filter civs by primary task */
];

if (isNil "GRAD_CIVS_fnc_getGlobalCivs_arr") then {
    // on first run, init array with existing civs
    private _potentialCivs = entities [[GVAR(CIVCLASS)], [], true, true];
    GRAD_CIVS_fnc_getGlobalCivs_arr = _potentialCivs select { (_x getVariable ["grad_civs_primaryTask", ""]) != ""};

    // then, register event handler to update the array appropriately to always include all living civs
    [
        QGVAR(civ_added),
        {
            SCRIPT("getGlobalCivs_civ_added");
            GRAD_CIVS_fnc_getGlobalCivs_arr = GRAD_CIVS_fnc_getGlobalCivs_arr + _this;
        }
    ] call CBA_fnc_addEventHandler;
    [
        QGVAR(civ_removed),
        {
            SCRIPT("getGlobalCivs_civ_removed");
            GRAD_CIVS_fnc_getGlobalCivs_arr = GRAD_CIVS_fnc_getGlobalCivs_arr - _this;
        }
    ] call CBA_fnc_addEventHandler;
};

if (_primaryTask == "") then {
    GRAD_CIVS_fnc_getGlobalCivs_arr
} else {
    (GRAD_CIVS_fnc_getGlobalCivs_arr select { _x getVariable ["grad_civs_primaryTask", ""] == _primaryTask})
};
