#include "..\script_component.hpp"

private _depoint = {
    private _pointees = player getVariable [QGVAR(gunpointees), []];
    {
        _pointees deleteAt (_pointees find _x);
        [QEGVAR(common,pointed_at_dec), [_x], [_x]] call CBA_fnc_targetEvent;
    } forEach _this;
    if (count _this > 0) then {
        [QGVAR(depointing), _this] call CBA_fnc_localEvent;
    };
};

private _point = {
    private _pointees = player getVariable [QGVAR(gunpointees), false];
    if (_pointees isEqualTo false) then {
        _pointees = [];
        player setVariable [QGVAR(gunpointees), _pointees];
    };
    {
        _pointees pushBackUnique _x;
        [QEGVAR(common,pointed_at_inc), [_x], [_x]] call CBA_fnc_targetEvent;
    } forEach _this;
    if (count _this > 0) then {
        [QGVAR(pointing), _this] call CBA_fnc_localEvent;
    };
};

// NOTE: we need to use animationState, as !weaponLowered does *not* mean "weaponRaised"
private _weaponRaisedOnFoot = (alive player) &&
    {!weaponLowered player} &&
    {vehicle player == player} &&
    {"sras" in (animationState player)};

private _pointees = player getVariable [QGVAR(gunpointees), []];

if (!_weaponRaisedOnFoot) exitWith {
    // I lowered my weapon. Everyone feels free to go. No one is added.
    _pointees call _depoint;
};

// I have my weapon raised. Check existing targets if they still feel threatened
private _scaredPointees = _pointees select {
    [player, _x] call FUNC(checkWeaponOnCivilianPerception);
};
(_pointees - _scaredPointees) call _depoint;

// maybe someone new here I can threaten?
private _possibleCiv = driver cursorTarget;
if (!(_possibleCiv in _pointees)) then {
    if (
        ((side _possibleCiv) == civilian) &&
        {alive _possibleCiv} &&
        {[player, _possibleCiv] call FUNC(checkWeaponOnCivilianPerception)}
    ) then {
        [_possibleCiv] call _point;
    };
};
