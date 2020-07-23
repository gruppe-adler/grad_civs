#include "..\script_component.hpp"

params [
    ["_civ", objNull, [objNull]]
];

if (!(local _civ)) exitWith {
    [QGVAR(do_dismiss_civ), [_civ], [_civ]] call CBA_fnc_targetEvent;
};

// take control from state machine first!
EGVAR(legacy,localCivs) = EGVAR(legacy,localCivs) - [_civ];

// reset AI capabilities that were disabled at the very start
_civ enableAI "TARGET";
_civ enableAI "AUTOTARGET";
_civ enableAI "FSM";
_civ enableAI "WEAPONAIM";
_civ enableAI "AIMINGERROR";
_civ enableAI "SUPPRESSION";
_civ enableAI "CHECKVISIBLE";
_civ enableAI "COVER";
_civ enableAI "AUTOCOMBAT";

// just to be sure - reset surrender stuff too
_civ enableAI "ANIM";
_civ enableAI "MOVE";

// ensure they will not get picked up again:
// remove all grad_civs vars
{
    if (_x find "grad_civs" == 0) then {
        _civ setVariable [_x, nil, true];
    };
} forEach allVariables _civ;

// trigger event last
["grad_civs_civ_removed", [_civ]] call CBA_fnc_globalEvent;

INFO_1("dismissed civ %1", _civ);
