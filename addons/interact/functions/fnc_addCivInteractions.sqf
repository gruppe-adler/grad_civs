#include "..\script_component.hpp"

private _civClasses = call EFUNC(lifecycle,config_getCivClasses);

private _carryOnAction = [
    QGVAR(carryOnAction),
    "carry on with your business",
    "", // icon
    {[_target] call FUNC(interact_carryOnAction)},
    {[_target] call FUNC(interact_carryOnCondition)}
] call ace_interact_menu_fnc_createAction;

private _backUpAction = [
    QGVAR(backUpAction),
    "back up your vehicle",
    "", // icon
    {[_target] call FUNC(interact_backUpAction)},
    {[_target] call FUNC(interact_backUpCondition)}
] call ace_interact_menu_fnc_createAction;


private _stopAction = [
    QGVAR(stopAction),
    "stop",
    "", // icon
    {[_target] call FUNC(interact_stopAction)},
    {[_target] call FUNC(interact_stopCondition)}
] call ace_interact_menu_fnc_createAction;

{
    private _action = _x;
    {
        [
            _x,
            0,
            ["ACE_MainActions"],
            _action,
            true
        ] call ace_interact_menu_fnc_addActionToClass;
    } forEach (_civClasses + ["Car"]);
} forEach [_stopAction, _backUpAction, _carryOnAction];
