#include "..\script_component.hpp"

private _civClasses = call EFUNC(common,config_getCivClasses);

private _carryOnAction = [
    QGVAR(carryOnAction),
    "carry on with your business",
    "", // icon
    FUNC(interact_carryOnAction),
    FUNC(interact_carryOnCondition)
] call ace_interact_menu_fnc_createAction;

{
    [
        _x,
        0,
        ["ACE_MainActions"],
        _carryOnAction,
        true
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _civClasses;

private _backUpAction = [
    QGVAR(carryOnAction),
    "back up your vehicle!",
    "", // icon
    FUNC(interact_backUpAction),
    FUNC(interact_backUpCondition)
] call ace_interact_menu_fnc_createAction;

{
    [
        _x,
        0,
        ["ACE_MainActions"],
        _backUpAction,
        true
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _civClasses;
