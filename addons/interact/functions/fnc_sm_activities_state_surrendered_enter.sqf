#include "..\script_component.hpp"

private _pointingPlayer = _this getVariable [QGVAR(pointingPlayer), objNull];
if !(isNull _pointingPlayer) then {
	private _dirVector = (getPos _pointingPlayer) vectorDiff (getPos _this);
	["ace_common_setVectorDirAndUp", [_this, [_dirVector, [0, 0, 1]]], _this] call CBA_fnc_targetEvent;
};

_this setVariable ["grad_civs_surrenderTime", CBA_missionTime];

if (!isNil "ACE_captives_fnc_setSurrendered") then {
	[_this, true] call ACE_captives_fnc_setSurrendered;
};

// the issue is that after dismounting, unit will sprint around. "doStop" does not seem to reliably and immediately work
_this disableAI "MOVE";
_this disableAI "ANIM";
