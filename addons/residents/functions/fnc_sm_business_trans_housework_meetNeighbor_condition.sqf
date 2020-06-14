#include "..\script_component.hpp"

private _neighborCooldown = [QGVAR(meetNeighborCooldown)] call CBA_settings_fnc_get;

if ((_this getVariable ["grad_civs_lastSocialContact", 0]) + _neighborCooldown > CBA_missionTime) exitWith {false};

private _neighborToMeet = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (!(isNull _neighborToMeet)) exitWith {
    [_this, format ["going to chat with %1", _neighborToMeet]] call EFUNC(legacy,setCurrentlyThinking);
    true
};

// run only every 10th time
if (random 10 < 9) exitWith {false};

private _neighborToMeet = {
    private _maxDist = _x;
    private _civClass = [QEGVAR(legacy,civClass)] call CBA_settings_fnc_get; // TODO: civclass is typeOf _this !
    private _nearCivs = (_this nearEntities [[_civClass], _maxDist]);
    private _socialNeighbors = _nearCivs select {
        (_x != _this) &&
        (_x getVariable ["grad_civs_primaryTask", ""] == "reside") &&
        (
            (_x getVariable ["grad_civs_neighborToMeet", objNull] == _this) ||
            ((_x getVariable ["grad_civs_lastSocialContact", 0]) + _neighborCooldown < CBA_missionTime)
        )
    };
    if (count _socialNeighbors > 0) exitWith {_socialNeighbors select 0};
} forEach [50, 100, 150];

if (isNil "_neighborToMeet") exitWith {false};
if (isNull _neighborToMeet) exitWith {false};

_this setVariable ["grad_civs_neighborToMeet", _neighborToMeet, true];
[_this, format ["going to chat with %1", _neighborToMeet]] call EFUNC(legacy,setCurrentlyThinking);
true
