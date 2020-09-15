#include "..\script_component.hpp"

/* ----------------------------------------------------------------------------
Parameters:
    _list           - list of anything over which the state machine will run
                      (type needs to support setVariable) <ARRAY>
                      OR
                      code that will generate this list, called once the list
                      has been cycled through <CODE>
    _skipNull       - skip list items that are null,
	_name           - (optional) string name for the state machine
---------------------------------------------------------------------------- */

params [
    ["_list", [], [[], {}]],
    ["_skipNull", false, [true]],
    ["_name", "", [""]]
];

private _sm = [_list, _skipNull] call CBA_statemachine_fnc_create;
_sm setVariable ["#var", _name];

_sm
