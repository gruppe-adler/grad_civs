#include "..\script_component.hpp"

params [
    ["_unit", objNull, [objNull]]
];

assert(!isNull _unit);
assert(local _unit);

if (random 1 > 0.5) then {
    _unit unlinkItem "ItemWatch";
};
if (random 1 > 0.05) then {
    _unit unlinkItem "ItemMap";
};
if (random 1 > 0.01) then {
    _unit unlinkItem "ItemCompass";
};

[
    QGVAR(clothes),
    _unit,
    {
        params ["_unit", "_value"];
        _unit addUniform _value;
    }
] call FUNC(applyRandomConfigArrayValue);

[
    QGVAR(headgear),
    _unit,
    {
        params ["_unit", "_value"];
        _unit addHeadgear _value;
    }
] call FUNC(applyRandomConfigArrayValue);

[
    QGVAR(faces),
    _unit,
    {
        [
            {
                [QGVAR(broadcastFace), _this] call CBA_fnc_globalEventJIP;
            },
            _this,
            2
        ] call CBA_fnc_waitAndExecute;
    }
] call FUNC(applyRandomConfigArrayValue);


[
    QGVAR(goggles),
    _unit,
    {
        params ["_unit", "_value"];
        _unit addGoggles _value;
    }
] call FUNC(applyRandomConfigArrayValue);

private _backpackProbability = [QGVAR(backpackProbability)] call cba_settings_fnc_get;
if (_backpackProbability > (random 1)) then {
    [
        QGVAR(backpacks),
        _unit,
        {
            params ["_unit", "_value"];
            _unit addBackpackGlobal _value;
        }
    ] call FUNC(applyRandomConfigArrayValue);
};
