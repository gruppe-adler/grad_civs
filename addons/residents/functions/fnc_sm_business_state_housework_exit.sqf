#include "..\script_component.hpp"

_this setVariable [QGVAR(housework_anim), nil];
_this call BIS_fnc_ambientAnim__terminate;
{_this disableAI _x} forEach ["AUTOTARGET", "FSM", "TARGET"]; //  BIS_fnc_ambientAnim__terminate enables some AI features
