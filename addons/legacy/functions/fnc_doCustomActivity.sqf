#include "..\script_component.hpp"
/*
    compel civilians to do your bidding.

    NOTE:
    * do clean up after yourself! (for example, re-enable AI flags you may have disabled in _doStart)
    * activity may be terminated at any time by other activities, or if grad-civs deems it necessary
    * activity will not even be started if civ is in a panic state
*/

params [
    ["_civ", objNull, [objNull]], // the civilian in question
    ["_doStart", {}, [{}]], // start activity. gets _civ as first parameter, plus values from _moreParameters
    ["_doEnd", {}, [{}]], // end activity. gets _civ as first parameter, plus values from _moreParameters
    ["_endConditionOrTimeout", 10, [0, {}]], // end activity when condition evaluates to true, or timeout in seconds
    ["_moreParameters", [], [[]]], // parameters to be passed to doStart and doEnd (optional)
    ["_name", "", [""]], // name for this activity (optional. for debugging purposes)
    ["_description", "", [""]] // description for this activity (optional. for debugging purposes)
];

assert(local _civ);

private _id = ([_name, call FUNC(uid)] select { _x != ""}) joinString "_";
INFO_2("civ %1: generated uid %2 for custom activity", _civ, _id);

private _timeout = 86400*366; // if you run a scenario for over one year, take this bug with love <3.
private _endCondition = _endConditionOrTimeout;
if (typeName _endConditionOrTimeout == typeName 0) then {
    INFO_2("civ %1: custom activity %2 seems to have timeout, will use that", _civ, _id);
    _timeout = _endConditionOrTimeout;
    _endCondition = {false};
} else {
    INFO_2("civ %1: custom activity %2 seems to have code, will use that", _civ, _id);
};

// force the previous custom activity to end
_currentCustomActivity = _civ getVariable [QGVAR(customActivity_id), ""];
if (_currentCustomActivity != "") then {
    INFO_2("civ %1: forcing previous custom activity %2 to end.", _civ, _currentCustomActivity);
    private _prevDoEnd = _civ getVariable [QGVAR(customActivity_doEnd), {}];
    private _prevParameters = _civ getVariable [QGVAR(customActivity_parameters), []];
    ([_civ] + _prevParameters) call _prevDoEnd;
    // no need to raise "customActivity_end" event when we start another custom activity anyway
    // no need to unset the civ variables when we're gonna assign them anyway further down
} else {
    [QGVAR(customActivity_start), [_civ], _civ] call CBA_fnc_targetEvent;
};

INFO_2("civ %1: starts custom activity %2", _civ, _id);

([_civ] + _moreParameters) call _doStart;

 // NOTE:
//        civ might change owner in which case this  will break, as I dont set vars as global.
 //       I am however afraid of broadcasting code (where I have no idea how large it is) everytime a civ does something special.
 //       Also, when civ changes owner it starts a new life anyway, so there's that /shrug
 //       If in doubt, that's the place where a lot of things (anim, AI props) should be reset anyway. (TODO)
_civ setVariable [QGVAR(customActivity_id), _id, true]; // needs to be global, serves as indicator for player interactions
_civ setVariable [QGVAR(customActivity_doEnd), _doEnd];
_civ setVariable [QGVAR(customActivity_parameters), _moreParameters];

private _endCode = {
    params  ["_civ", "_id"];

    if (_civ getVariable [QGVAR(customActivity_id), ""] == _id) then {
        INFO_2("civ %1: ending custom activity %2", _civ, _id);
        private _doEnd = _civ getVariable [QGVAR(customActivity_doEnd), {}];
        private _moreParameters = _civ getVariable [QGVAR(customActivity_parameters), []];
        ([_civ] + _moreParameters) call _doEnd;
        _this call _doEnd;

        _civ setVariable [QGVAR(customActivity_id), nil, true];
        _civ setVariable [QGVAR(customActivity_doEnd), nil];
        _civ setVariable [QGVAR(customActivity_parameters), nil];

        [QGVAR(customActivity_end), [_civ], _civ] call CBA_fnc_targetEvent;
    } else {
        WARNING_2("civ %1: CANNOT end custom activity %2 , must've been cut short by sth else", _civ, _id);
    };
};

[
    _endCondition,
    _endCode,
    [_civ, _id],
    _timeout,
    _endCode
] call CBA_fnc_waitUntilAndExecute;
