#include "..\..\component.hpp"

params [
    ["_vehicle", objNull],
    ["_targetPos", [0, 0, 0]],
    ["_timeout", -1],
    ["_onDone", {}],
    ["_abortCondition", {false}]
];

#define TARGET_PRECISION 5 /*precision in meters*/

scopeName "main";

private _driver = driver _vehicle;
if (isNull _driver) exitWith {
    INFO_1("not reversing vehicle %1: no driver present", _vehicle);
};

if (effectiveCommander _vehicle == _driver) then {
    private _ec = objNull;
    if ((count (crew _vehicle)) == 1) then {
        private _hasEmpty = (fullCrew [_vehicle, "", true]) findIf { isNull (_x#0) } != -1;
        if (!_hasEmpty) then {
            WARNING_1("cannot reverse vehicle %1 as there's no free crew seat", _vehicle);
            breakOut "main";
        };
        _ec = (group _driver) createUnit ["C_Soldier_VR_F", [0, 0, 0], [], 0, "NONE"];
        if (!GVAR(DEBUG_CIVSTATE)) then {
            ["ace_common_hideObjectGlobal", [_ec, true]] call CBA_fnc_serverEvent;
        };
        _ec assignAsCargo _vehicle;
        _ec moveInCargo _vehicle;
        _ec setVariable ["grad_civs_virtual_ec", true];
    } else {
        _ec = (crew _vehicle)#1;
    };

    INFO_1("setting EC to %1", typeOf _ec);
    _vehicle setEffectiveCommander _ec;
};

private _pfhHandle = [FUNC(reverse_internal_pfh), 0, [_vehicle, _targetPos]] call CBA_fnc_addPerFrameHandler;

_vehicle setVariable [QGVAR(abortReverse), nil, true];
// _vehicle setVelocityModelSpace [0, -2, 0];
INFO_3("starting reverse drive! PFH %1 for %2 will time out after %3s", _pfhHandle, _vehicle, _timeout);

[
    FUNC(reverse_internal_stopCondition),
    FUNC(reverse_internal_end),
    [_pfhHandle, _vehicle, _targetPos, CBA_missionTime + 4, _onDone, _abortCondition], /*HACK try at last for 4s, because it may take some time to stop & reverse*/
    _timeout,
    FUNC(reverse_internal_end)
] call CBA_fnc_waitUntilAndExecute;
