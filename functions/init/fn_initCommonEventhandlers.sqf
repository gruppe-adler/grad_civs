#include "..\..\component.hpp"

params [
    ["_mode", "runtime"]
];
if (_mode == "postInit" && {([missionConfigFile >> "cfgGradCivs", "autoInit", 0] call BIS_fnc_returnConfigEntry) != 1}) exitWith {INFO("autoInit disabled, not running initCommonEventhandlers right now...")};

[QGVAR(switchMove), {
        params ["_unit", "_animation"];
        _unit switchMove _animation;
    }
] call CBA_fnc_addEventHandler;


["ace_common_playActionNow", {
    params ["_unit", "_animation"];
    if (!local _unit) exitWith {
        WARNING_2("got playActionNow event %1 non-local unit %2!", _animation _unit);
    };
    [_unit, _animation] call FUNC(handleAnimation);
}] call CBA_fnc_addEventHandler;
