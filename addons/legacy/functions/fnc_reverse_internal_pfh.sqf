#include "..\script_component.hpp"

params ["_args", "_handle"];
_args params ["_car"];

_car sendSimpleCommand "BACK";
